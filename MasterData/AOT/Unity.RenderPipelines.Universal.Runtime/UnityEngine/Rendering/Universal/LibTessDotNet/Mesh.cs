using System.Diagnostics;

namespace UnityEngine.Rendering.Universal.LibTessDotNet;

internal class Mesh : MeshUtils.Pooled<Mesh>
{
	internal MeshUtils.Vertex _vHead;

	internal MeshUtils.Face _fHead;

	internal MeshUtils.Edge _eHead;

	internal MeshUtils.Edge _eHeadSym;

	public Mesh()
	{
		MeshUtils.Vertex vertex = (_vHead = MeshUtils.Pooled<MeshUtils.Vertex>.Create());
		MeshUtils.Face face = (_fHead = MeshUtils.Pooled<MeshUtils.Face>.Create());
		MeshUtils.EdgePair edgePair = MeshUtils.EdgePair.Create();
		MeshUtils.Edge edge = (_eHead = edgePair._e);
		MeshUtils.Edge edge2 = (_eHeadSym = edgePair._eSym);
		vertex._next = (vertex._prev = vertex);
		vertex._anEdge = null;
		face._next = (face._prev = face);
		face._anEdge = null;
		face._trail = null;
		face._marked = false;
		face._inside = false;
		edge._next = edge;
		edge._Sym = edge2;
		edge._Onext = null;
		edge._Lnext = null;
		edge._Org = null;
		edge._Lface = null;
		edge._winding = 0;
		edge._activeRegion = null;
		edge2._next = edge2;
		edge2._Sym = edge;
		edge2._Onext = null;
		edge2._Lnext = null;
		edge2._Org = null;
		edge2._Lface = null;
		edge2._winding = 0;
		edge2._activeRegion = null;
	}

	public override void Reset()
	{
		_vHead = null;
		_fHead = null;
		_eHead = (_eHeadSym = null);
	}

	public override void OnFree()
	{
		MeshUtils.Face face = _fHead._next;
		MeshUtils.Face fHead = _fHead;
		while (face != _fHead)
		{
			fHead = face._next;
			face.Free();
			face = fHead;
		}
		MeshUtils.Vertex vertex = _vHead._next;
		MeshUtils.Vertex vHead = _vHead;
		while (vertex != _vHead)
		{
			vHead = vertex._next;
			vertex.Free();
			vertex = vHead;
		}
		MeshUtils.Edge edge = _eHead._next;
		MeshUtils.Edge eHead = _eHead;
		while (edge != _eHead)
		{
			eHead = edge._next;
			edge.Free();
			edge = eHead;
		}
	}

	public MeshUtils.Edge MakeEdge()
	{
		MeshUtils.Edge edge = MeshUtils.MakeEdge(_eHead);
		MeshUtils.MakeVertex(edge, _vHead);
		MeshUtils.MakeVertex(edge._Sym, _vHead);
		MeshUtils.MakeFace(edge, _fHead);
		return edge;
	}

	public void Splice(MeshUtils.Edge eOrg, MeshUtils.Edge eDst)
	{
		if (eOrg != eDst)
		{
			bool flag = false;
			if (eDst._Org != eOrg._Org)
			{
				flag = true;
				MeshUtils.KillVertex(eDst._Org, eOrg._Org);
			}
			bool flag2 = false;
			if (eDst._Lface != eOrg._Lface)
			{
				flag2 = true;
				MeshUtils.KillFace(eDst._Lface, eOrg._Lface);
			}
			MeshUtils.Splice(eDst, eOrg);
			if (!flag)
			{
				MeshUtils.MakeVertex(eDst, eOrg._Org);
				eOrg._Org._anEdge = eOrg;
			}
			if (!flag2)
			{
				MeshUtils.MakeFace(eDst, eOrg._Lface);
				eOrg._Lface._anEdge = eOrg;
			}
		}
	}

	public void Delete(MeshUtils.Edge eDel)
	{
		MeshUtils.Edge sym = eDel._Sym;
		bool flag = false;
		if (eDel._Lface != eDel._Rface)
		{
			flag = true;
			MeshUtils.KillFace(eDel._Lface, eDel._Rface);
		}
		if (eDel._Onext == eDel)
		{
			MeshUtils.KillVertex(eDel._Org, null);
		}
		else
		{
			eDel._Rface._anEdge = eDel._Oprev;
			eDel._Org._anEdge = eDel._Onext;
			MeshUtils.Splice(eDel, eDel._Oprev);
			if (!flag)
			{
				MeshUtils.MakeFace(eDel, eDel._Lface);
			}
		}
		if (sym._Onext == sym)
		{
			MeshUtils.KillVertex(sym._Org, null);
			MeshUtils.KillFace(sym._Lface, null);
		}
		else
		{
			eDel._Lface._anEdge = sym._Oprev;
			sym._Org._anEdge = sym._Onext;
			MeshUtils.Splice(sym, sym._Oprev);
		}
		MeshUtils.KillEdge(eDel);
	}

	public MeshUtils.Edge AddEdgeVertex(MeshUtils.Edge eOrg)
	{
		MeshUtils.Edge edge = MeshUtils.MakeEdge(eOrg);
		MeshUtils.Edge sym = edge._Sym;
		MeshUtils.Splice(edge, eOrg._Lnext);
		edge._Org = eOrg._Dst;
		MeshUtils.MakeVertex(sym, edge._Org);
		edge._Lface = (sym._Lface = eOrg._Lface);
		return edge;
	}

	public MeshUtils.Edge SplitEdge(MeshUtils.Edge eOrg)
	{
		MeshUtils.Edge sym = AddEdgeVertex(eOrg)._Sym;
		MeshUtils.Splice(eOrg._Sym, eOrg._Sym._Oprev);
		MeshUtils.Splice(eOrg._Sym, sym);
		eOrg._Dst = sym._Org;
		sym._Dst._anEdge = sym._Sym;
		sym._Rface = eOrg._Rface;
		sym._winding = eOrg._winding;
		sym._Sym._winding = eOrg._Sym._winding;
		return sym;
	}

	public MeshUtils.Edge Connect(MeshUtils.Edge eOrg, MeshUtils.Edge eDst)
	{
		MeshUtils.Edge edge = MeshUtils.MakeEdge(eOrg);
		MeshUtils.Edge sym = edge._Sym;
		bool flag = false;
		if (eDst._Lface != eOrg._Lface)
		{
			flag = true;
			MeshUtils.KillFace(eDst._Lface, eOrg._Lface);
		}
		MeshUtils.Splice(edge, eOrg._Lnext);
		MeshUtils.Splice(sym, eDst);
		edge._Org = eOrg._Dst;
		sym._Org = eDst._Org;
		edge._Lface = (sym._Lface = eOrg._Lface);
		eOrg._Lface._anEdge = sym;
		if (!flag)
		{
			MeshUtils.MakeFace(edge, eOrg._Lface);
		}
		return edge;
	}

	public void ZapFace(MeshUtils.Face fZap)
	{
		MeshUtils.Edge anEdge = fZap._anEdge;
		MeshUtils.Edge lnext = anEdge._Lnext;
		MeshUtils.Edge edge;
		do
		{
			edge = lnext;
			lnext = edge._Lnext;
			edge._Lface = null;
			if (edge._Rface == null)
			{
				if (edge._Onext == edge)
				{
					MeshUtils.KillVertex(edge._Org, null);
				}
				else
				{
					edge._Org._anEdge = edge._Onext;
					MeshUtils.Splice(edge, edge._Oprev);
				}
				MeshUtils.Edge sym = edge._Sym;
				if (sym._Onext == sym)
				{
					MeshUtils.KillVertex(sym._Org, null);
				}
				else
				{
					sym._Org._anEdge = sym._Onext;
					MeshUtils.Splice(sym, sym._Oprev);
				}
				MeshUtils.KillEdge(edge);
			}
		}
		while (edge != anEdge);
		MeshUtils.Face prev = fZap._prev;
		MeshUtils.Face next = fZap._next;
		next._prev = prev;
		prev._next = next;
		fZap.Free();
	}

	public void MergeConvexFaces(int maxVertsPerFace)
	{
		for (MeshUtils.Face next = _fHead._next; next != _fHead; next = next._next)
		{
			if (next._inside)
			{
				MeshUtils.Edge edge = next._anEdge;
				MeshUtils.Vertex org = edge._Org;
				while (true)
				{
					MeshUtils.Edge lnext = edge._Lnext;
					MeshUtils.Edge sym = edge._Sym;
					if (sym != null && sym._Lface != null && sym._Lface._inside)
					{
						int vertsCount = next.VertsCount;
						int vertsCount2 = sym._Lface.VertsCount;
						if (vertsCount + vertsCount2 - 2 <= maxVertsPerFace && Geom.VertCCW(edge._Lprev._Org, edge._Org, sym._Lnext._Lnext._Org) && Geom.VertCCW(sym._Lprev._Org, sym._Org, edge._Lnext._Lnext._Org))
						{
							lnext = sym._Lnext;
							Delete(sym);
							edge = null;
						}
					}
					if (edge != null && edge._Lnext._Org == org)
					{
						break;
					}
					edge = lnext;
				}
			}
		}
	}

	[Conditional("DEBUG")]
	public void Check()
	{
		MeshUtils.Face fHead = _fHead;
		fHead = _fHead;
		MeshUtils.Face next;
		MeshUtils.Edge edge;
		while ((next = fHead._next) != _fHead)
		{
			edge = next._anEdge;
			do
			{
				edge = edge._Lnext;
			}
			while (edge != next._anEdge);
			fHead = next;
		}
		MeshUtils.Vertex vHead = _vHead;
		vHead = _vHead;
		MeshUtils.Vertex next2;
		while ((next2 = vHead._next) != _vHead)
		{
			edge = next2._anEdge;
			do
			{
				edge = edge._Onext;
			}
			while (edge != next2._anEdge);
			vHead = next2;
		}
		MeshUtils.Edge eHead = _eHead;
		eHead = _eHead;
		while ((edge = eHead._next) != _eHead)
		{
			eHead = edge;
		}
	}
}

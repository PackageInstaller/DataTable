using System;
using System.Collections.Generic;

namespace Cinemachine;

internal static class ClipperLib
{
	public struct DoublePoint
	{
		public double X;

		public double Y;

		public DoublePoint(double x = 0.0, double y = 0.0)
		{
			X = x;
			Y = y;
		}

		public DoublePoint(DoublePoint dp)
		{
			X = dp.X;
			Y = dp.Y;
		}

		public DoublePoint(IntPoint ip)
		{
			X = ip.X;
			Y = ip.Y;
		}
	}

	public class PolyTree : PolyNode
	{
		internal List<PolyNode> m_AllPolys = new List<PolyNode>();

		public int Total
		{
			get
			{
				int num = m_AllPolys.Count;
				if (num > 0 && m_Childs[0] != m_AllPolys[0])
				{
					num--;
				}
				return num;
			}
		}

		public void Clear()
		{
			for (int i = 0; i < m_AllPolys.Count; i++)
			{
				m_AllPolys[i] = null;
			}
			m_AllPolys.Clear();
			m_Childs.Clear();
		}

		public PolyNode GetFirst()
		{
			if (m_Childs.Count > 0)
			{
				return m_Childs[0];
			}
			return null;
		}
	}

	public class PolyNode
	{
		internal PolyNode m_Parent;

		internal List<IntPoint> m_polygon = new List<IntPoint>();

		internal int m_Index;

		internal JoinType m_jointype;

		internal EndType m_endtype;

		internal List<PolyNode> m_Childs = new List<PolyNode>();

		public int ChildCount => m_Childs.Count;

		public List<IntPoint> Contour => m_polygon;

		public List<PolyNode> Childs => m_Childs;

		public PolyNode Parent => m_Parent;

		public bool IsHole => IsHoleNode();

		public bool IsOpen { get; set; }

		private bool IsHoleNode()
		{
			bool flag = true;
			for (PolyNode parent = m_Parent; parent != null; parent = parent.m_Parent)
			{
				flag = !flag;
			}
			return flag;
		}

		internal void AddChild(PolyNode Child)
		{
			int count = m_Childs.Count;
			m_Childs.Add(Child);
			Child.m_Parent = this;
			Child.m_Index = count;
		}

		public PolyNode GetNext()
		{
			if (m_Childs.Count > 0)
			{
				return m_Childs[0];
			}
			return GetNextSiblingUp();
		}

		internal PolyNode GetNextSiblingUp()
		{
			if (m_Parent == null)
			{
				return null;
			}
			if (m_Index == m_Parent.m_Childs.Count - 1)
			{
				return m_Parent.GetNextSiblingUp();
			}
			return m_Parent.m_Childs[m_Index + 1];
		}
	}

	internal struct Int128
	{
		private long hi;

		private ulong lo;

		public Int128(long _lo)
		{
			lo = (ulong)_lo;
			if (_lo < 0)
			{
				hi = -1L;
			}
			else
			{
				hi = 0L;
			}
		}

		public Int128(long _hi, ulong _lo)
		{
			lo = _lo;
			hi = _hi;
		}

		public Int128(Int128 val)
		{
			hi = val.hi;
			lo = val.lo;
		}

		public bool IsNegative()
		{
			return hi < 0;
		}

		public static bool operator ==(Int128 val1, Int128 val2)
		{
			if ((object)val1 == (object)val2)
			{
				return true;
			}
			if ((object)val1 == null || (object)val2 == null)
			{
				return false;
			}
			if (val1.hi == val2.hi)
			{
				return val1.lo == val2.lo;
			}
			return false;
		}

		public static bool operator !=(Int128 val1, Int128 val2)
		{
			return !(val1 == val2);
		}

		public override bool Equals(object obj)
		{
			if (obj == null || !(obj is Int128 @int))
			{
				return false;
			}
			if (@int.hi == hi)
			{
				return @int.lo == lo;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return hi.GetHashCode() ^ lo.GetHashCode();
		}

		public static bool operator >(Int128 val1, Int128 val2)
		{
			if (val1.hi != val2.hi)
			{
				return val1.hi > val2.hi;
			}
			return val1.lo > val2.lo;
		}

		public static bool operator <(Int128 val1, Int128 val2)
		{
			if (val1.hi != val2.hi)
			{
				return val1.hi < val2.hi;
			}
			return val1.lo < val2.lo;
		}

		public static Int128 operator +(Int128 lhs, Int128 rhs)
		{
			lhs.hi += rhs.hi;
			lhs.lo += rhs.lo;
			if (lhs.lo < rhs.lo)
			{
				lhs.hi++;
			}
			return lhs;
		}

		public static Int128 operator -(Int128 lhs, Int128 rhs)
		{
			return lhs + -rhs;
		}

		public static Int128 operator -(Int128 val)
		{
			if (val.lo == 0L)
			{
				return new Int128(-val.hi, 0uL);
			}
			return new Int128(~val.hi, ~val.lo + 1);
		}

		public static explicit operator double(Int128 val)
		{
			if (val.hi < 0)
			{
				if (val.lo == 0L)
				{
					return (double)val.hi * 1.8446744073709552E+19;
				}
				return 0.0 - ((double)(~val.lo) + (double)(~val.hi) * 1.8446744073709552E+19);
			}
			return (double)val.lo + (double)val.hi * 1.8446744073709552E+19;
		}

		public static Int128 Int128Mul(long lhs, long rhs)
		{
			bool num = lhs < 0 != rhs < 0;
			if (lhs < 0)
			{
				lhs = -lhs;
			}
			if (rhs < 0)
			{
				rhs = -rhs;
			}
			long num2 = lhs >>> 32;
			ulong num3 = (ulong)(lhs & 0xFFFFFFFFu);
			ulong num4 = (ulong)rhs >> 32;
			ulong num5 = (ulong)(rhs & 0xFFFFFFFFu);
			ulong num6 = (ulong)num2 * num4;
			ulong num7 = num3 * num5;
			ulong num8 = (ulong)(num2 * (long)num5) + num3 * num4;
			long num9 = (long)(num6 + (num8 >> 32));
			ulong num10 = (num8 << 32) + num7;
			if (num10 < num7)
			{
				num9++;
			}
			Int128 @int = new Int128(num9, num10);
			if (!num)
			{
				return @int;
			}
			return -@int;
		}
	}

	public struct IntPoint
	{
		public long X;

		public long Y;

		public IntPoint(long X, long Y)
		{
			this.X = X;
			this.Y = Y;
		}

		public IntPoint(double x, double y)
		{
			X = (long)x;
			Y = (long)y;
		}

		public IntPoint(IntPoint pt)
		{
			X = pt.X;
			Y = pt.Y;
		}

		public static bool operator ==(IntPoint a, IntPoint b)
		{
			if (a.X == b.X)
			{
				return a.Y == b.Y;
			}
			return false;
		}

		public static bool operator !=(IntPoint a, IntPoint b)
		{
			if (a.X == b.X)
			{
				return a.Y != b.Y;
			}
			return true;
		}

		public override bool Equals(object obj)
		{
			if (obj == null)
			{
				return false;
			}
			if (obj is IntPoint intPoint)
			{
				if (X == intPoint.X)
				{
					return Y == intPoint.Y;
				}
				return false;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return base.GetHashCode();
		}
	}

	public struct IntRect
	{
		public long left;

		public long top;

		public long right;

		public long bottom;

		public IntRect(long l, long t, long r, long b)
		{
			left = l;
			top = t;
			right = r;
			bottom = b;
		}

		public IntRect(IntRect ir)
		{
			left = ir.left;
			top = ir.top;
			right = ir.right;
			bottom = ir.bottom;
		}
	}

	public enum ClipType
	{
		ctIntersection,
		ctUnion,
		ctDifference,
		ctXor
	}

	public enum PolyType
	{
		ptSubject,
		ptClip
	}

	public enum PolyFillType
	{
		pftEvenOdd,
		pftNonZero,
		pftPositive,
		pftNegative
	}

	public enum JoinType
	{
		jtSquare,
		jtRound,
		jtMiter
	}

	public enum EndType
	{
		etClosedPolygon,
		etClosedLine,
		etOpenButt,
		etOpenSquare,
		etOpenRound
	}

	internal enum EdgeSide
	{
		esLeft,
		esRight
	}

	internal enum Direction
	{
		dRightToLeft,
		dLeftToRight
	}

	internal class TEdge
	{
		internal IntPoint Bot;

		internal IntPoint Curr;

		internal IntPoint Top;

		internal IntPoint Delta;

		internal double Dx;

		internal PolyType PolyTyp;

		internal EdgeSide Side;

		internal int WindDelta;

		internal int WindCnt;

		internal int WindCnt2;

		internal int OutIdx;

		internal TEdge Next;

		internal TEdge Prev;

		internal TEdge NextInLML;

		internal TEdge NextInAEL;

		internal TEdge PrevInAEL;

		internal TEdge NextInSEL;

		internal TEdge PrevInSEL;
	}

	public class IntersectNode
	{
		internal TEdge Edge1;

		internal TEdge Edge2;

		internal IntPoint Pt;
	}

	public class MyIntersectNodeSort : IComparer<IntersectNode>
	{
		public int Compare(IntersectNode node1, IntersectNode node2)
		{
			long num = node2.Pt.Y - node1.Pt.Y;
			if (num > 0)
			{
				return 1;
			}
			if (num < 0)
			{
				return -1;
			}
			return 0;
		}
	}

	internal class LocalMinima
	{
		internal long Y;

		internal TEdge LeftBound;

		internal TEdge RightBound;

		internal LocalMinima Next;
	}

	internal class Scanbeam
	{
		internal long Y;

		internal Scanbeam Next;
	}

	internal class Maxima
	{
		internal long X;

		internal Maxima Next;

		internal Maxima Prev;
	}

	internal class OutRec
	{
		internal int Idx;

		internal bool IsHole;

		internal bool IsOpen;

		internal OutRec FirstLeft;

		internal OutPt Pts;

		internal OutPt BottomPt;

		internal PolyNode PolyNode;
	}

	internal class OutPt
	{
		internal int Idx;

		internal IntPoint Pt;

		internal OutPt Next;

		internal OutPt Prev;
	}

	internal class Join
	{
		internal OutPt OutPt1;

		internal OutPt OutPt2;

		internal IntPoint OffPt;
	}

	public class ClipperBase
	{
		internal const double horizontal = -3.4E+38;

		internal const int Skip = -2;

		internal const int Unassigned = -1;

		internal const double tolerance = 1E-20;

		public const long loRange = 1073741823L;

		public const long hiRange = 4611686018427387903L;

		internal LocalMinima m_MinimaList;

		internal LocalMinima m_CurrentLM;

		internal List<List<TEdge>> m_edges = new List<List<TEdge>>();

		internal Scanbeam m_Scanbeam;

		internal List<OutRec> m_PolyOuts;

		internal TEdge m_ActiveEdges;

		internal bool m_UseFullRange;

		internal bool m_HasOpenPaths;

		public bool PreserveCollinear { get; set; }

		internal static bool near_zero(double val)
		{
			if (val > -1E-20)
			{
				return val < 1E-20;
			}
			return false;
		}

		public void Swap(ref long val1, ref long val2)
		{
			long num = val1;
			val1 = val2;
			val2 = num;
		}

		internal static bool IsHorizontal(TEdge e)
		{
			return e.Delta.Y == 0;
		}

		internal bool PointIsVertex(IntPoint pt, OutPt pp)
		{
			OutPt outPt = pp;
			do
			{
				if (outPt.Pt == pt)
				{
					return true;
				}
				outPt = outPt.Next;
			}
			while (outPt != pp);
			return false;
		}

		internal bool PointOnLineSegment(IntPoint pt, IntPoint linePt1, IntPoint linePt2, bool UseFullRange)
		{
			if (UseFullRange)
			{
				if ((pt.X != linePt1.X || pt.Y != linePt1.Y) && (pt.X != linePt2.X || pt.Y != linePt2.Y))
				{
					if (pt.X > linePt1.X == pt.X < linePt2.X && pt.Y > linePt1.Y == pt.Y < linePt2.Y)
					{
						return Int128.Int128Mul(pt.X - linePt1.X, linePt2.Y - linePt1.Y) == Int128.Int128Mul(linePt2.X - linePt1.X, pt.Y - linePt1.Y);
					}
					return false;
				}
				return true;
			}
			if ((pt.X != linePt1.X || pt.Y != linePt1.Y) && (pt.X != linePt2.X || pt.Y != linePt2.Y))
			{
				if (pt.X > linePt1.X == pt.X < linePt2.X && pt.Y > linePt1.Y == pt.Y < linePt2.Y)
				{
					return (pt.X - linePt1.X) * (linePt2.Y - linePt1.Y) == (linePt2.X - linePt1.X) * (pt.Y - linePt1.Y);
				}
				return false;
			}
			return true;
		}

		internal bool PointOnPolygon(IntPoint pt, OutPt pp, bool UseFullRange)
		{
			OutPt outPt = pp;
			do
			{
				if (PointOnLineSegment(pt, outPt.Pt, outPt.Next.Pt, UseFullRange))
				{
					return true;
				}
				outPt = outPt.Next;
			}
			while (outPt != pp);
			return false;
		}

		internal static bool SlopesEqual(TEdge e1, TEdge e2, bool UseFullRange)
		{
			if (UseFullRange)
			{
				return Int128.Int128Mul(e1.Delta.Y, e2.Delta.X) == Int128.Int128Mul(e1.Delta.X, e2.Delta.Y);
			}
			return e1.Delta.Y * e2.Delta.X == e1.Delta.X * e2.Delta.Y;
		}

		internal static bool SlopesEqual(IntPoint pt1, IntPoint pt2, IntPoint pt3, bool UseFullRange)
		{
			if (UseFullRange)
			{
				return Int128.Int128Mul(pt1.Y - pt2.Y, pt2.X - pt3.X) == Int128.Int128Mul(pt1.X - pt2.X, pt2.Y - pt3.Y);
			}
			return (pt1.Y - pt2.Y) * (pt2.X - pt3.X) - (pt1.X - pt2.X) * (pt2.Y - pt3.Y) == 0;
		}

		internal static bool SlopesEqual(IntPoint pt1, IntPoint pt2, IntPoint pt3, IntPoint pt4, bool UseFullRange)
		{
			if (UseFullRange)
			{
				return Int128.Int128Mul(pt1.Y - pt2.Y, pt3.X - pt4.X) == Int128.Int128Mul(pt1.X - pt2.X, pt3.Y - pt4.Y);
			}
			return (pt1.Y - pt2.Y) * (pt3.X - pt4.X) - (pt1.X - pt2.X) * (pt3.Y - pt4.Y) == 0;
		}

		internal ClipperBase()
		{
			m_MinimaList = null;
			m_CurrentLM = null;
			m_UseFullRange = false;
			m_HasOpenPaths = false;
		}

		public virtual void Clear()
		{
			DisposeLocalMinimaList();
			for (int i = 0; i < m_edges.Count; i++)
			{
				for (int j = 0; j < m_edges[i].Count; j++)
				{
					m_edges[i][j] = null;
				}
				m_edges[i].Clear();
			}
			m_edges.Clear();
			m_UseFullRange = false;
			m_HasOpenPaths = false;
		}

		private void DisposeLocalMinimaList()
		{
			while (m_MinimaList != null)
			{
				LocalMinima next = m_MinimaList.Next;
				m_MinimaList = null;
				m_MinimaList = next;
			}
			m_CurrentLM = null;
		}

		private void RangeTest(IntPoint Pt, ref bool useFullRange)
		{
			if (useFullRange)
			{
				if (Pt.X > 4611686018427387903L || Pt.Y > 4611686018427387903L || -Pt.X > 4611686018427387903L || -Pt.Y > 4611686018427387903L)
				{
					throw new ClipperException("Coordinate outside allowed range");
				}
			}
			else if (Pt.X > 1073741823 || Pt.Y > 1073741823 || -Pt.X > 1073741823 || -Pt.Y > 1073741823)
			{
				useFullRange = true;
				RangeTest(Pt, ref useFullRange);
			}
		}

		private void InitEdge(TEdge e, TEdge eNext, TEdge ePrev, IntPoint pt)
		{
			e.Next = eNext;
			e.Prev = ePrev;
			e.Curr = pt;
			e.OutIdx = -1;
		}

		private void InitEdge2(TEdge e, PolyType polyType)
		{
			if (e.Curr.Y >= e.Next.Curr.Y)
			{
				e.Bot = e.Curr;
				e.Top = e.Next.Curr;
			}
			else
			{
				e.Top = e.Curr;
				e.Bot = e.Next.Curr;
			}
			SetDx(e);
			e.PolyTyp = polyType;
		}

		private TEdge FindNextLocMin(TEdge E)
		{
			while (true)
			{
				if (E.Bot != E.Prev.Bot || E.Curr == E.Top)
				{
					E = E.Next;
					continue;
				}
				if (E.Dx != -3.4E+38 && E.Prev.Dx != -3.4E+38)
				{
					break;
				}
				while (E.Prev.Dx == -3.4E+38)
				{
					E = E.Prev;
				}
				TEdge tEdge = E;
				while (E.Dx == -3.4E+38)
				{
					E = E.Next;
				}
				if (E.Top.Y != E.Prev.Bot.Y)
				{
					if (tEdge.Prev.Bot.X < E.Bot.X)
					{
						E = tEdge;
					}
					break;
				}
			}
			return E;
		}

		private TEdge ProcessBound(TEdge E, bool LeftBoundIsForward)
		{
			TEdge tEdge = E;
			if (tEdge.OutIdx == -2)
			{
				E = tEdge;
				if (LeftBoundIsForward)
				{
					while (E.Top.Y == E.Next.Bot.Y)
					{
						E = E.Next;
					}
					while (E != tEdge && E.Dx == -3.4E+38)
					{
						E = E.Prev;
					}
				}
				else
				{
					while (E.Top.Y == E.Prev.Bot.Y)
					{
						E = E.Prev;
					}
					while (E != tEdge && E.Dx == -3.4E+38)
					{
						E = E.Next;
					}
				}
				if (E == tEdge)
				{
					tEdge = ((!LeftBoundIsForward) ? E.Prev : E.Next);
				}
				else
				{
					E = ((!LeftBoundIsForward) ? tEdge.Prev : tEdge.Next);
					LocalMinima localMinima = new LocalMinima();
					localMinima.Next = null;
					localMinima.Y = E.Bot.Y;
					localMinima.LeftBound = null;
					localMinima.RightBound = E;
					E.WindDelta = 0;
					tEdge = ProcessBound(E, LeftBoundIsForward);
					InsertLocalMinima(localMinima);
				}
				return tEdge;
			}
			TEdge tEdge2;
			if (E.Dx == -3.4E+38)
			{
				tEdge2 = ((!LeftBoundIsForward) ? E.Next : E.Prev);
				if (tEdge2.Dx == -3.4E+38)
				{
					if (tEdge2.Bot.X != E.Bot.X && tEdge2.Top.X != E.Bot.X)
					{
						ReverseHorizontal(E);
					}
				}
				else if (tEdge2.Bot.X != E.Bot.X)
				{
					ReverseHorizontal(E);
				}
			}
			tEdge2 = E;
			if (LeftBoundIsForward)
			{
				while (tEdge.Top.Y == tEdge.Next.Bot.Y && tEdge.Next.OutIdx != -2)
				{
					tEdge = tEdge.Next;
				}
				if (tEdge.Dx == -3.4E+38 && tEdge.Next.OutIdx != -2)
				{
					TEdge tEdge3 = tEdge;
					while (tEdge3.Prev.Dx == -3.4E+38)
					{
						tEdge3 = tEdge3.Prev;
					}
					if (tEdge3.Prev.Top.X > tEdge.Next.Top.X)
					{
						tEdge = tEdge3.Prev;
					}
				}
				while (E != tEdge)
				{
					E.NextInLML = E.Next;
					if (E.Dx == -3.4E+38 && E != tEdge2 && E.Bot.X != E.Prev.Top.X)
					{
						ReverseHorizontal(E);
					}
					E = E.Next;
				}
				if (E.Dx == -3.4E+38 && E != tEdge2 && E.Bot.X != E.Prev.Top.X)
				{
					ReverseHorizontal(E);
				}
				return tEdge.Next;
			}
			while (tEdge.Top.Y == tEdge.Prev.Bot.Y && tEdge.Prev.OutIdx != -2)
			{
				tEdge = tEdge.Prev;
			}
			if (tEdge.Dx == -3.4E+38 && tEdge.Prev.OutIdx != -2)
			{
				TEdge tEdge3 = tEdge;
				while (tEdge3.Next.Dx == -3.4E+38)
				{
					tEdge3 = tEdge3.Next;
				}
				if (tEdge3.Next.Top.X == tEdge.Prev.Top.X || tEdge3.Next.Top.X > tEdge.Prev.Top.X)
				{
					tEdge = tEdge3.Next;
				}
			}
			while (E != tEdge)
			{
				E.NextInLML = E.Prev;
				if (E.Dx == -3.4E+38 && E != tEdge2 && E.Bot.X != E.Next.Top.X)
				{
					ReverseHorizontal(E);
				}
				E = E.Prev;
			}
			if (E.Dx == -3.4E+38 && E != tEdge2 && E.Bot.X != E.Next.Top.X)
			{
				ReverseHorizontal(E);
			}
			return tEdge.Prev;
		}

		public bool AddPath(List<IntPoint> pg, PolyType polyType, bool Closed)
		{
			if (!Closed && polyType == PolyType.ptClip)
			{
				throw new ClipperException("AddPath: Open paths must be subject.");
			}
			int num = pg.Count - 1;
			if (Closed)
			{
				while (num > 0 && pg[num] == pg[0])
				{
					num--;
				}
			}
			while (num > 0 && pg[num] == pg[num - 1])
			{
				num--;
			}
			if ((Closed && num < 2) || (!Closed && num < 1))
			{
				return false;
			}
			List<TEdge> list = new List<TEdge>(num + 1);
			for (int i = 0; i <= num; i++)
			{
				list.Add(new TEdge());
			}
			bool flag = true;
			list[1].Curr = pg[1];
			RangeTest(pg[0], ref m_UseFullRange);
			RangeTest(pg[num], ref m_UseFullRange);
			InitEdge(list[0], list[1], list[num], pg[0]);
			InitEdge(list[num], list[0], list[num - 1], pg[num]);
			for (int num2 = num - 1; num2 >= 1; num2--)
			{
				RangeTest(pg[num2], ref m_UseFullRange);
				InitEdge(list[num2], list[num2 + 1], list[num2 - 1], pg[num2]);
			}
			TEdge tEdge = list[0];
			TEdge tEdge2 = tEdge;
			TEdge tEdge3 = tEdge;
			while (true)
			{
				if (tEdge2.Curr == tEdge2.Next.Curr && (Closed || tEdge2.Next != tEdge))
				{
					if (tEdge2 == tEdge2.Next)
					{
						break;
					}
					if (tEdge2 == tEdge)
					{
						tEdge = tEdge2.Next;
					}
					tEdge2 = RemoveEdge(tEdge2);
					tEdge3 = tEdge2;
					continue;
				}
				if (tEdge2.Prev == tEdge2.Next)
				{
					break;
				}
				if (Closed && SlopesEqual(tEdge2.Prev.Curr, tEdge2.Curr, tEdge2.Next.Curr, m_UseFullRange) && (!PreserveCollinear || !Pt2IsBetweenPt1AndPt3(tEdge2.Prev.Curr, tEdge2.Curr, tEdge2.Next.Curr)))
				{
					if (tEdge2 == tEdge)
					{
						tEdge = tEdge2.Next;
					}
					tEdge2 = RemoveEdge(tEdge2);
					tEdge2 = tEdge2.Prev;
					tEdge3 = tEdge2;
				}
				else
				{
					tEdge2 = tEdge2.Next;
					if (tEdge2 == tEdge3 || (!Closed && tEdge2.Next == tEdge))
					{
						break;
					}
				}
			}
			if ((!Closed && tEdge2 == tEdge2.Next) || (Closed && tEdge2.Prev == tEdge2.Next))
			{
				return false;
			}
			if (!Closed)
			{
				m_HasOpenPaths = true;
				tEdge.Prev.OutIdx = -2;
			}
			tEdge2 = tEdge;
			do
			{
				InitEdge2(tEdge2, polyType);
				tEdge2 = tEdge2.Next;
				if (flag && tEdge2.Curr.Y != tEdge.Curr.Y)
				{
					flag = false;
				}
			}
			while (tEdge2 != tEdge);
			if (flag)
			{
				if (Closed)
				{
					return false;
				}
				tEdge2.Prev.OutIdx = -2;
				LocalMinima localMinima = new LocalMinima();
				localMinima.Next = null;
				localMinima.Y = tEdge2.Bot.Y;
				localMinima.LeftBound = null;
				localMinima.RightBound = tEdge2;
				localMinima.RightBound.Side = EdgeSide.esRight;
				localMinima.RightBound.WindDelta = 0;
				while (true)
				{
					if (tEdge2.Bot.X != tEdge2.Prev.Top.X)
					{
						ReverseHorizontal(tEdge2);
					}
					if (tEdge2.Next.OutIdx == -2)
					{
						break;
					}
					tEdge2.NextInLML = tEdge2.Next;
					tEdge2 = tEdge2.Next;
				}
				InsertLocalMinima(localMinima);
				m_edges.Add(list);
				return true;
			}
			m_edges.Add(list);
			TEdge tEdge4 = null;
			if (tEdge2.Prev.Bot == tEdge2.Prev.Top)
			{
				tEdge2 = tEdge2.Next;
			}
			while (true)
			{
				tEdge2 = FindNextLocMin(tEdge2);
				if (tEdge2 == tEdge4)
				{
					break;
				}
				if (tEdge4 == null)
				{
					tEdge4 = tEdge2;
				}
				LocalMinima localMinima2 = new LocalMinima();
				localMinima2.Next = null;
				localMinima2.Y = tEdge2.Bot.Y;
				bool flag2;
				if (tEdge2.Dx < tEdge2.Prev.Dx)
				{
					localMinima2.LeftBound = tEdge2.Prev;
					localMinima2.RightBound = tEdge2;
					flag2 = false;
				}
				else
				{
					localMinima2.LeftBound = tEdge2;
					localMinima2.RightBound = tEdge2.Prev;
					flag2 = true;
				}
				localMinima2.LeftBound.Side = EdgeSide.esLeft;
				localMinima2.RightBound.Side = EdgeSide.esRight;
				if (!Closed)
				{
					localMinima2.LeftBound.WindDelta = 0;
				}
				else if (localMinima2.LeftBound.Next == localMinima2.RightBound)
				{
					localMinima2.LeftBound.WindDelta = -1;
				}
				else
				{
					localMinima2.LeftBound.WindDelta = 1;
				}
				localMinima2.RightBound.WindDelta = -localMinima2.LeftBound.WindDelta;
				tEdge2 = ProcessBound(localMinima2.LeftBound, flag2);
				if (tEdge2.OutIdx == -2)
				{
					tEdge2 = ProcessBound(tEdge2, flag2);
				}
				TEdge tEdge5 = ProcessBound(localMinima2.RightBound, !flag2);
				if (tEdge5.OutIdx == -2)
				{
					tEdge5 = ProcessBound(tEdge5, !flag2);
				}
				if (localMinima2.LeftBound.OutIdx == -2)
				{
					localMinima2.LeftBound = null;
				}
				else if (localMinima2.RightBound.OutIdx == -2)
				{
					localMinima2.RightBound = null;
				}
				InsertLocalMinima(localMinima2);
				if (!flag2)
				{
					tEdge2 = tEdge5;
				}
			}
			return true;
		}

		public bool AddPaths(List<List<IntPoint>> ppg, PolyType polyType, bool closed)
		{
			bool result = false;
			for (int i = 0; i < ppg.Count; i++)
			{
				if (AddPath(ppg[i], polyType, closed))
				{
					result = true;
				}
			}
			return result;
		}

		internal bool Pt2IsBetweenPt1AndPt3(IntPoint pt1, IntPoint pt2, IntPoint pt3)
		{
			if (pt1 == pt3 || pt1 == pt2 || pt3 == pt2)
			{
				return false;
			}
			if (pt1.X != pt3.X)
			{
				return pt2.X > pt1.X == pt2.X < pt3.X;
			}
			return pt2.Y > pt1.Y == pt2.Y < pt3.Y;
		}

		private TEdge RemoveEdge(TEdge e)
		{
			e.Prev.Next = e.Next;
			e.Next.Prev = e.Prev;
			TEdge next = e.Next;
			e.Prev = null;
			return next;
		}

		private void SetDx(TEdge e)
		{
			e.Delta.X = e.Top.X - e.Bot.X;
			e.Delta.Y = e.Top.Y - e.Bot.Y;
			if (e.Delta.Y == 0L)
			{
				e.Dx = -3.4E+38;
			}
			else
			{
				e.Dx = (double)e.Delta.X / (double)e.Delta.Y;
			}
		}

		private void InsertLocalMinima(LocalMinima newLm)
		{
			if (m_MinimaList == null)
			{
				m_MinimaList = newLm;
				return;
			}
			if (newLm.Y >= m_MinimaList.Y)
			{
				newLm.Next = m_MinimaList;
				m_MinimaList = newLm;
				return;
			}
			LocalMinima localMinima = m_MinimaList;
			while (localMinima.Next != null && newLm.Y < localMinima.Next.Y)
			{
				localMinima = localMinima.Next;
			}
			newLm.Next = localMinima.Next;
			localMinima.Next = newLm;
		}

		internal bool PopLocalMinima(long Y, out LocalMinima current)
		{
			current = m_CurrentLM;
			if (m_CurrentLM != null && m_CurrentLM.Y == Y)
			{
				m_CurrentLM = m_CurrentLM.Next;
				return true;
			}
			return false;
		}

		private void ReverseHorizontal(TEdge e)
		{
			Swap(ref e.Top.X, ref e.Bot.X);
		}

		internal virtual void Reset()
		{
			m_CurrentLM = m_MinimaList;
			if (m_CurrentLM == null)
			{
				return;
			}
			m_Scanbeam = null;
			for (LocalMinima localMinima = m_MinimaList; localMinima != null; localMinima = localMinima.Next)
			{
				InsertScanbeam(localMinima.Y);
				TEdge leftBound = localMinima.LeftBound;
				if (leftBound != null)
				{
					leftBound.Curr = leftBound.Bot;
					leftBound.OutIdx = -1;
				}
				leftBound = localMinima.RightBound;
				if (leftBound != null)
				{
					leftBound.Curr = leftBound.Bot;
					leftBound.OutIdx = -1;
				}
			}
			m_ActiveEdges = null;
		}

		public static IntRect GetBounds(List<List<IntPoint>> paths)
		{
			int i = 0;
			int count;
			for (count = paths.Count; i < count && paths[i].Count == 0; i++)
			{
			}
			if (i == count)
			{
				return new IntRect(0L, 0L, 0L, 0L);
			}
			IntRect result = default(IntRect);
			result.left = paths[i][0].X;
			result.right = result.left;
			result.top = paths[i][0].Y;
			result.bottom = result.top;
			for (; i < count; i++)
			{
				for (int j = 0; j < paths[i].Count; j++)
				{
					if (paths[i][j].X < result.left)
					{
						result.left = paths[i][j].X;
					}
					else if (paths[i][j].X > result.right)
					{
						result.right = paths[i][j].X;
					}
					if (paths[i][j].Y < result.top)
					{
						result.top = paths[i][j].Y;
					}
					else if (paths[i][j].Y > result.bottom)
					{
						result.bottom = paths[i][j].Y;
					}
				}
			}
			return result;
		}

		internal void InsertScanbeam(long Y)
		{
			if (m_Scanbeam == null)
			{
				m_Scanbeam = new Scanbeam();
				m_Scanbeam.Next = null;
				m_Scanbeam.Y = Y;
				return;
			}
			if (Y > m_Scanbeam.Y)
			{
				Scanbeam scanbeam = new Scanbeam();
				scanbeam.Y = Y;
				scanbeam.Next = m_Scanbeam;
				m_Scanbeam = scanbeam;
				return;
			}
			Scanbeam scanbeam2 = m_Scanbeam;
			while (scanbeam2.Next != null && Y <= scanbeam2.Next.Y)
			{
				scanbeam2 = scanbeam2.Next;
			}
			if (Y != scanbeam2.Y)
			{
				Scanbeam scanbeam3 = new Scanbeam();
				scanbeam3.Y = Y;
				scanbeam3.Next = scanbeam2.Next;
				scanbeam2.Next = scanbeam3;
			}
		}

		internal bool PopScanbeam(out long Y)
		{
			if (m_Scanbeam == null)
			{
				Y = 0L;
				return false;
			}
			Y = m_Scanbeam.Y;
			m_Scanbeam = m_Scanbeam.Next;
			return true;
		}

		internal bool LocalMinimaPending()
		{
			return m_CurrentLM != null;
		}

		internal OutRec CreateOutRec()
		{
			OutRec outRec = new OutRec();
			outRec.Idx = -1;
			outRec.IsHole = false;
			outRec.IsOpen = false;
			outRec.FirstLeft = null;
			outRec.Pts = null;
			outRec.BottomPt = null;
			outRec.PolyNode = null;
			m_PolyOuts.Add(outRec);
			outRec.Idx = m_PolyOuts.Count - 1;
			return outRec;
		}

		internal void DisposeOutRec(int index)
		{
			m_PolyOuts[index].Pts = null;
			m_PolyOuts[index] = null;
		}

		internal void UpdateEdgeIntoAEL(ref TEdge e)
		{
			if (e.NextInLML == null)
			{
				throw new ClipperException("UpdateEdgeIntoAEL: invalid call");
			}
			TEdge prevInAEL = e.PrevInAEL;
			TEdge nextInAEL = e.NextInAEL;
			e.NextInLML.OutIdx = e.OutIdx;
			if (prevInAEL != null)
			{
				prevInAEL.NextInAEL = e.NextInLML;
			}
			else
			{
				m_ActiveEdges = e.NextInLML;
			}
			if (nextInAEL != null)
			{
				nextInAEL.PrevInAEL = e.NextInLML;
			}
			e.NextInLML.Side = e.Side;
			e.NextInLML.WindDelta = e.WindDelta;
			e.NextInLML.WindCnt = e.WindCnt;
			e.NextInLML.WindCnt2 = e.WindCnt2;
			e = e.NextInLML;
			e.Curr = e.Bot;
			e.PrevInAEL = prevInAEL;
			e.NextInAEL = nextInAEL;
			if (!IsHorizontal(e))
			{
				InsertScanbeam(e.Top.Y);
			}
		}

		internal void SwapPositionsInAEL(TEdge edge1, TEdge edge2)
		{
			if (edge1.NextInAEL == edge1.PrevInAEL || edge2.NextInAEL == edge2.PrevInAEL)
			{
				return;
			}
			if (edge1.NextInAEL == edge2)
			{
				TEdge nextInAEL = edge2.NextInAEL;
				if (nextInAEL != null)
				{
					nextInAEL.PrevInAEL = edge1;
				}
				TEdge prevInAEL = edge1.PrevInAEL;
				if (prevInAEL != null)
				{
					prevInAEL.NextInAEL = edge2;
				}
				edge2.PrevInAEL = prevInAEL;
				edge2.NextInAEL = edge1;
				edge1.PrevInAEL = edge2;
				edge1.NextInAEL = nextInAEL;
			}
			else if (edge2.NextInAEL == edge1)
			{
				TEdge nextInAEL2 = edge1.NextInAEL;
				if (nextInAEL2 != null)
				{
					nextInAEL2.PrevInAEL = edge2;
				}
				TEdge prevInAEL2 = edge2.PrevInAEL;
				if (prevInAEL2 != null)
				{
					prevInAEL2.NextInAEL = edge1;
				}
				edge1.PrevInAEL = prevInAEL2;
				edge1.NextInAEL = edge2;
				edge2.PrevInAEL = edge1;
				edge2.NextInAEL = nextInAEL2;
			}
			else
			{
				TEdge nextInAEL3 = edge1.NextInAEL;
				TEdge prevInAEL3 = edge1.PrevInAEL;
				edge1.NextInAEL = edge2.NextInAEL;
				if (edge1.NextInAEL != null)
				{
					edge1.NextInAEL.PrevInAEL = edge1;
				}
				edge1.PrevInAEL = edge2.PrevInAEL;
				if (edge1.PrevInAEL != null)
				{
					edge1.PrevInAEL.NextInAEL = edge1;
				}
				edge2.NextInAEL = nextInAEL3;
				if (edge2.NextInAEL != null)
				{
					edge2.NextInAEL.PrevInAEL = edge2;
				}
				edge2.PrevInAEL = prevInAEL3;
				if (edge2.PrevInAEL != null)
				{
					edge2.PrevInAEL.NextInAEL = edge2;
				}
			}
			if (edge1.PrevInAEL == null)
			{
				m_ActiveEdges = edge1;
			}
			else if (edge2.PrevInAEL == null)
			{
				m_ActiveEdges = edge2;
			}
		}

		internal void DeleteFromAEL(TEdge e)
		{
			TEdge prevInAEL = e.PrevInAEL;
			TEdge nextInAEL = e.NextInAEL;
			if (prevInAEL != null || nextInAEL != null || e == m_ActiveEdges)
			{
				if (prevInAEL != null)
				{
					prevInAEL.NextInAEL = nextInAEL;
				}
				else
				{
					m_ActiveEdges = nextInAEL;
				}
				if (nextInAEL != null)
				{
					nextInAEL.PrevInAEL = prevInAEL;
				}
				e.NextInAEL = null;
				e.PrevInAEL = null;
			}
		}
	}

	public class Clipper : ClipperBase
	{
		internal enum NodeType
		{
			ntAny,
			ntOpen,
			ntClosed
		}

		public const int ioReverseSolution = 1;

		public const int ioStrictlySimple = 2;

		public const int ioPreserveCollinear = 4;

		private ClipType m_ClipType;

		private Maxima m_Maxima;

		private TEdge m_SortedEdges;

		private List<IntersectNode> m_IntersectList;

		private IComparer<IntersectNode> m_IntersectNodeComparer;

		private bool m_ExecuteLocked;

		private PolyFillType m_ClipFillType;

		private PolyFillType m_SubjFillType;

		private List<Join> m_Joins;

		private List<Join> m_GhostJoins;

		private bool m_UsingPolyTree;

		public bool ReverseSolution { get; set; }

		public bool StrictlySimple { get; set; }

		public Clipper(int InitOptions = 0)
		{
			m_Scanbeam = null;
			m_Maxima = null;
			m_ActiveEdges = null;
			m_SortedEdges = null;
			m_IntersectList = new List<IntersectNode>();
			m_IntersectNodeComparer = new MyIntersectNodeSort();
			m_ExecuteLocked = false;
			m_UsingPolyTree = false;
			m_PolyOuts = new List<OutRec>();
			m_Joins = new List<Join>();
			m_GhostJoins = new List<Join>();
			ReverseSolution = (1 & InitOptions) != 0;
			StrictlySimple = (2 & InitOptions) != 0;
			base.PreserveCollinear = (4 & InitOptions) != 0;
		}

		private void InsertMaxima(long X)
		{
			Maxima maxima = new Maxima();
			maxima.X = X;
			if (m_Maxima == null)
			{
				m_Maxima = maxima;
				m_Maxima.Next = null;
				m_Maxima.Prev = null;
				return;
			}
			if (X < m_Maxima.X)
			{
				maxima.Next = m_Maxima;
				maxima.Prev = null;
				m_Maxima = maxima;
				return;
			}
			Maxima maxima2 = m_Maxima;
			while (maxima2.Next != null && X >= maxima2.Next.X)
			{
				maxima2 = maxima2.Next;
			}
			if (X != maxima2.X)
			{
				maxima.Next = maxima2.Next;
				maxima.Prev = maxima2;
				if (maxima2.Next != null)
				{
					maxima2.Next.Prev = maxima;
				}
				maxima2.Next = maxima;
			}
		}

		public bool Execute(ClipType clipType, List<List<IntPoint>> solution, PolyFillType FillType = PolyFillType.pftEvenOdd)
		{
			return Execute(clipType, solution, FillType, FillType);
		}

		public bool Execute(ClipType clipType, PolyTree polytree, PolyFillType FillType = PolyFillType.pftEvenOdd)
		{
			return Execute(clipType, polytree, FillType, FillType);
		}

		public bool Execute(ClipType clipType, List<List<IntPoint>> solution, PolyFillType subjFillType, PolyFillType clipFillType)
		{
			if (m_ExecuteLocked)
			{
				return false;
			}
			if (m_HasOpenPaths)
			{
				throw new ClipperException("Error: PolyTree struct is needed for open path clipping.");
			}
			m_ExecuteLocked = true;
			solution.Clear();
			m_SubjFillType = subjFillType;
			m_ClipFillType = clipFillType;
			m_ClipType = clipType;
			m_UsingPolyTree = false;
			bool flag;
			try
			{
				flag = ExecuteInternal();
				if (flag)
				{
					BuildResult(solution);
				}
			}
			finally
			{
				DisposeAllPolyPts();
				m_ExecuteLocked = false;
			}
			return flag;
		}

		public bool Execute(ClipType clipType, PolyTree polytree, PolyFillType subjFillType, PolyFillType clipFillType)
		{
			if (m_ExecuteLocked)
			{
				return false;
			}
			m_ExecuteLocked = true;
			m_SubjFillType = subjFillType;
			m_ClipFillType = clipFillType;
			m_ClipType = clipType;
			m_UsingPolyTree = true;
			bool flag;
			try
			{
				flag = ExecuteInternal();
				if (flag)
				{
					BuildResult2(polytree);
				}
			}
			finally
			{
				DisposeAllPolyPts();
				m_ExecuteLocked = false;
			}
			return flag;
		}

		internal void FixHoleLinkage(OutRec outRec)
		{
			if (outRec.FirstLeft != null && (outRec.IsHole == outRec.FirstLeft.IsHole || outRec.FirstLeft.Pts == null))
			{
				OutRec firstLeft = outRec.FirstLeft;
				while (firstLeft != null && (firstLeft.IsHole == outRec.IsHole || firstLeft.Pts == null))
				{
					firstLeft = firstLeft.FirstLeft;
				}
				outRec.FirstLeft = firstLeft;
			}
		}

		private bool ExecuteInternal()
		{
			try
			{
				Reset();
				m_SortedEdges = null;
				m_Maxima = null;
				if (!PopScanbeam(out var Y))
				{
					return false;
				}
				InsertLocalMinimaIntoAEL(Y);
				long Y2;
				while (PopScanbeam(out Y2) || LocalMinimaPending())
				{
					ProcessHorizontals();
					m_GhostJoins.Clear();
					if (!ProcessIntersections(Y2))
					{
						return false;
					}
					ProcessEdgesAtTopOfScanbeam(Y2);
					Y = Y2;
					InsertLocalMinimaIntoAEL(Y);
				}
				foreach (OutRec polyOut in m_PolyOuts)
				{
					if (polyOut.Pts != null && !polyOut.IsOpen && (polyOut.IsHole ^ ReverseSolution) == Area(polyOut) > 0.0)
					{
						ReversePolyPtLinks(polyOut.Pts);
					}
				}
				JoinCommonEdges();
				foreach (OutRec polyOut2 in m_PolyOuts)
				{
					if (polyOut2.Pts != null)
					{
						if (polyOut2.IsOpen)
						{
							FixupOutPolyline(polyOut2);
						}
						else
						{
							FixupOutPolygon(polyOut2);
						}
					}
				}
				if (StrictlySimple)
				{
					DoSimplePolygons();
				}
				return true;
			}
			finally
			{
				m_Joins.Clear();
				m_GhostJoins.Clear();
			}
		}

		private void DisposeAllPolyPts()
		{
			for (int i = 0; i < m_PolyOuts.Count; i++)
			{
				DisposeOutRec(i);
			}
			m_PolyOuts.Clear();
		}

		private void AddJoin(OutPt Op1, OutPt Op2, IntPoint OffPt)
		{
			Join obj = new Join();
			obj.OutPt1 = Op1;
			obj.OutPt2 = Op2;
			obj.OffPt = OffPt;
			m_Joins.Add(obj);
		}

		private void AddGhostJoin(OutPt Op, IntPoint OffPt)
		{
			Join obj = new Join();
			obj.OutPt1 = Op;
			obj.OffPt = OffPt;
			m_GhostJoins.Add(obj);
		}

		private void InsertLocalMinimaIntoAEL(long botY)
		{
			LocalMinima current;
			while (PopLocalMinima(botY, out current))
			{
				TEdge leftBound = current.LeftBound;
				TEdge rightBound = current.RightBound;
				OutPt outPt = null;
				if (leftBound == null)
				{
					InsertEdgeIntoAEL(rightBound, null);
					SetWindingCount(rightBound);
					if (IsContributing(rightBound))
					{
						outPt = AddOutPt(rightBound, rightBound.Bot);
					}
				}
				else if (rightBound == null)
				{
					InsertEdgeIntoAEL(leftBound, null);
					SetWindingCount(leftBound);
					if (IsContributing(leftBound))
					{
						outPt = AddOutPt(leftBound, leftBound.Bot);
					}
					InsertScanbeam(leftBound.Top.Y);
				}
				else
				{
					InsertEdgeIntoAEL(leftBound, null);
					InsertEdgeIntoAEL(rightBound, leftBound);
					SetWindingCount(leftBound);
					rightBound.WindCnt = leftBound.WindCnt;
					rightBound.WindCnt2 = leftBound.WindCnt2;
					if (IsContributing(leftBound))
					{
						outPt = AddLocalMinPoly(leftBound, rightBound, leftBound.Bot);
					}
					InsertScanbeam(leftBound.Top.Y);
				}
				if (rightBound != null)
				{
					if (ClipperBase.IsHorizontal(rightBound))
					{
						if (rightBound.NextInLML != null)
						{
							InsertScanbeam(rightBound.NextInLML.Top.Y);
						}
						AddEdgeToSEL(rightBound);
					}
					else
					{
						InsertScanbeam(rightBound.Top.Y);
					}
				}
				if (leftBound == null || rightBound == null)
				{
					continue;
				}
				if (outPt != null && ClipperBase.IsHorizontal(rightBound) && m_GhostJoins.Count > 0 && rightBound.WindDelta != 0)
				{
					for (int i = 0; i < m_GhostJoins.Count; i++)
					{
						Join obj = m_GhostJoins[i];
						if (HorzSegmentsOverlap(obj.OutPt1.Pt.X, obj.OffPt.X, rightBound.Bot.X, rightBound.Top.X))
						{
							AddJoin(obj.OutPt1, outPt, obj.OffPt);
						}
					}
				}
				if (leftBound.OutIdx >= 0 && leftBound.PrevInAEL != null && leftBound.PrevInAEL.Curr.X == leftBound.Bot.X && leftBound.PrevInAEL.OutIdx >= 0 && ClipperBase.SlopesEqual(leftBound.PrevInAEL.Curr, leftBound.PrevInAEL.Top, leftBound.Curr, leftBound.Top, m_UseFullRange) && leftBound.WindDelta != 0 && leftBound.PrevInAEL.WindDelta != 0)
				{
					OutPt op = AddOutPt(leftBound.PrevInAEL, leftBound.Bot);
					AddJoin(outPt, op, leftBound.Top);
				}
				if (leftBound.NextInAEL == rightBound)
				{
					continue;
				}
				if (rightBound.OutIdx >= 0 && rightBound.PrevInAEL.OutIdx >= 0 && ClipperBase.SlopesEqual(rightBound.PrevInAEL.Curr, rightBound.PrevInAEL.Top, rightBound.Curr, rightBound.Top, m_UseFullRange) && rightBound.WindDelta != 0 && rightBound.PrevInAEL.WindDelta != 0)
				{
					OutPt op2 = AddOutPt(rightBound.PrevInAEL, rightBound.Bot);
					AddJoin(outPt, op2, rightBound.Top);
				}
				TEdge nextInAEL = leftBound.NextInAEL;
				if (nextInAEL != null)
				{
					while (nextInAEL != rightBound)
					{
						IntersectEdges(rightBound, nextInAEL, leftBound.Curr);
						nextInAEL = nextInAEL.NextInAEL;
					}
				}
			}
		}

		private void InsertEdgeIntoAEL(TEdge edge, TEdge startEdge)
		{
			if (m_ActiveEdges == null)
			{
				edge.PrevInAEL = null;
				edge.NextInAEL = null;
				m_ActiveEdges = edge;
				return;
			}
			if (startEdge == null && E2InsertsBeforeE1(m_ActiveEdges, edge))
			{
				edge.PrevInAEL = null;
				edge.NextInAEL = m_ActiveEdges;
				m_ActiveEdges.PrevInAEL = edge;
				m_ActiveEdges = edge;
				return;
			}
			if (startEdge == null)
			{
				startEdge = m_ActiveEdges;
			}
			while (startEdge.NextInAEL != null && !E2InsertsBeforeE1(startEdge.NextInAEL, edge))
			{
				startEdge = startEdge.NextInAEL;
			}
			edge.NextInAEL = startEdge.NextInAEL;
			if (startEdge.NextInAEL != null)
			{
				startEdge.NextInAEL.PrevInAEL = edge;
			}
			edge.PrevInAEL = startEdge;
			startEdge.NextInAEL = edge;
		}

		private bool E2InsertsBeforeE1(TEdge e1, TEdge e2)
		{
			if (e2.Curr.X == e1.Curr.X)
			{
				if (e2.Top.Y > e1.Top.Y)
				{
					return e2.Top.X < TopX(e1, e2.Top.Y);
				}
				return e1.Top.X > TopX(e2, e1.Top.Y);
			}
			return e2.Curr.X < e1.Curr.X;
		}

		private bool IsEvenOddFillType(TEdge edge)
		{
			if (edge.PolyTyp == PolyType.ptSubject)
			{
				return m_SubjFillType == PolyFillType.pftEvenOdd;
			}
			return m_ClipFillType == PolyFillType.pftEvenOdd;
		}

		private bool IsEvenOddAltFillType(TEdge edge)
		{
			if (edge.PolyTyp == PolyType.ptSubject)
			{
				return m_ClipFillType == PolyFillType.pftEvenOdd;
			}
			return m_SubjFillType == PolyFillType.pftEvenOdd;
		}

		private bool IsContributing(TEdge edge)
		{
			PolyFillType polyFillType;
			PolyFillType polyFillType2;
			if (edge.PolyTyp == PolyType.ptSubject)
			{
				polyFillType = m_SubjFillType;
				polyFillType2 = m_ClipFillType;
			}
			else
			{
				polyFillType = m_ClipFillType;
				polyFillType2 = m_SubjFillType;
			}
			switch (polyFillType)
			{
			case PolyFillType.pftEvenOdd:
				if (edge.WindDelta == 0 && edge.WindCnt != 1)
				{
					return false;
				}
				break;
			case PolyFillType.pftNonZero:
				if (Math.Abs(edge.WindCnt) != 1)
				{
					return false;
				}
				break;
			case PolyFillType.pftPositive:
				if (edge.WindCnt != 1)
				{
					return false;
				}
				break;
			default:
				if (edge.WindCnt != -1)
				{
					return false;
				}
				break;
			}
			switch (m_ClipType)
			{
			case ClipType.ctIntersection:
				switch (polyFillType2)
				{
				case PolyFillType.pftEvenOdd:
				case PolyFillType.pftNonZero:
					return edge.WindCnt2 != 0;
				case PolyFillType.pftPositive:
					return edge.WindCnt2 > 0;
				default:
					return edge.WindCnt2 < 0;
				}
			case ClipType.ctUnion:
				switch (polyFillType2)
				{
				case PolyFillType.pftEvenOdd:
				case PolyFillType.pftNonZero:
					return edge.WindCnt2 == 0;
				case PolyFillType.pftPositive:
					return edge.WindCnt2 <= 0;
				default:
					return edge.WindCnt2 >= 0;
				}
			case ClipType.ctDifference:
				if (edge.PolyTyp == PolyType.ptSubject)
				{
					switch (polyFillType2)
					{
					case PolyFillType.pftEvenOdd:
					case PolyFillType.pftNonZero:
						return edge.WindCnt2 == 0;
					case PolyFillType.pftPositive:
						return edge.WindCnt2 <= 0;
					default:
						return edge.WindCnt2 >= 0;
					}
				}
				switch (polyFillType2)
				{
				case PolyFillType.pftEvenOdd:
				case PolyFillType.pftNonZero:
					return edge.WindCnt2 != 0;
				case PolyFillType.pftPositive:
					return edge.WindCnt2 > 0;
				default:
					return edge.WindCnt2 < 0;
				}
			case ClipType.ctXor:
				if (edge.WindDelta == 0)
				{
					switch (polyFillType2)
					{
					case PolyFillType.pftEvenOdd:
					case PolyFillType.pftNonZero:
						return edge.WindCnt2 == 0;
					case PolyFillType.pftPositive:
						return edge.WindCnt2 <= 0;
					default:
						return edge.WindCnt2 >= 0;
					}
				}
				return true;
			default:
				return true;
			}
		}

		private void SetWindingCount(TEdge edge)
		{
			TEdge prevInAEL = edge.PrevInAEL;
			while (prevInAEL != null && (prevInAEL.PolyTyp != edge.PolyTyp || prevInAEL.WindDelta == 0))
			{
				prevInAEL = prevInAEL.PrevInAEL;
			}
			if (prevInAEL == null)
			{
				PolyFillType polyFillType = ((edge.PolyTyp == PolyType.ptSubject) ? m_SubjFillType : m_ClipFillType);
				if (edge.WindDelta == 0)
				{
					edge.WindCnt = ((polyFillType != PolyFillType.pftNegative) ? 1 : (-1));
				}
				else
				{
					edge.WindCnt = edge.WindDelta;
				}
				edge.WindCnt2 = 0;
				prevInAEL = m_ActiveEdges;
			}
			else if (edge.WindDelta == 0 && m_ClipType != ClipType.ctUnion)
			{
				edge.WindCnt = 1;
				edge.WindCnt2 = prevInAEL.WindCnt2;
				prevInAEL = prevInAEL.NextInAEL;
			}
			else if (IsEvenOddFillType(edge))
			{
				if (edge.WindDelta == 0)
				{
					bool flag = true;
					for (TEdge prevInAEL2 = prevInAEL.PrevInAEL; prevInAEL2 != null; prevInAEL2 = prevInAEL2.PrevInAEL)
					{
						if (prevInAEL2.PolyTyp == prevInAEL.PolyTyp && prevInAEL2.WindDelta != 0)
						{
							flag = !flag;
						}
					}
					edge.WindCnt = ((!flag) ? 1 : 0);
				}
				else
				{
					edge.WindCnt = edge.WindDelta;
				}
				edge.WindCnt2 = prevInAEL.WindCnt2;
				prevInAEL = prevInAEL.NextInAEL;
			}
			else
			{
				if (prevInAEL.WindCnt * prevInAEL.WindDelta < 0)
				{
					if (Math.Abs(prevInAEL.WindCnt) > 1)
					{
						if (prevInAEL.WindDelta * edge.WindDelta < 0)
						{
							edge.WindCnt = prevInAEL.WindCnt;
						}
						else
						{
							edge.WindCnt = prevInAEL.WindCnt + edge.WindDelta;
						}
					}
					else
					{
						edge.WindCnt = ((edge.WindDelta == 0) ? 1 : edge.WindDelta);
					}
				}
				else if (edge.WindDelta == 0)
				{
					edge.WindCnt = ((prevInAEL.WindCnt < 0) ? (prevInAEL.WindCnt - 1) : (prevInAEL.WindCnt + 1));
				}
				else if (prevInAEL.WindDelta * edge.WindDelta < 0)
				{
					edge.WindCnt = prevInAEL.WindCnt;
				}
				else
				{
					edge.WindCnt = prevInAEL.WindCnt + edge.WindDelta;
				}
				edge.WindCnt2 = prevInAEL.WindCnt2;
				prevInAEL = prevInAEL.NextInAEL;
			}
			if (IsEvenOddAltFillType(edge))
			{
				while (prevInAEL != edge)
				{
					if (prevInAEL.WindDelta != 0)
					{
						edge.WindCnt2 = ((edge.WindCnt2 == 0) ? 1 : 0);
					}
					prevInAEL = prevInAEL.NextInAEL;
				}
			}
			else
			{
				while (prevInAEL != edge)
				{
					edge.WindCnt2 += prevInAEL.WindDelta;
					prevInAEL = prevInAEL.NextInAEL;
				}
			}
		}

		private void AddEdgeToSEL(TEdge edge)
		{
			if (m_SortedEdges == null)
			{
				m_SortedEdges = edge;
				edge.PrevInSEL = null;
				edge.NextInSEL = null;
			}
			else
			{
				edge.NextInSEL = m_SortedEdges;
				edge.PrevInSEL = null;
				m_SortedEdges.PrevInSEL = edge;
				m_SortedEdges = edge;
			}
		}

		internal bool PopEdgeFromSEL(out TEdge e)
		{
			e = m_SortedEdges;
			if (e == null)
			{
				return false;
			}
			TEdge obj = e;
			m_SortedEdges = e.NextInSEL;
			if (m_SortedEdges != null)
			{
				m_SortedEdges.PrevInSEL = null;
			}
			obj.NextInSEL = null;
			obj.PrevInSEL = null;
			return true;
		}

		private void CopyAELToSEL()
		{
			for (TEdge tEdge = (m_SortedEdges = m_ActiveEdges); tEdge != null; tEdge = tEdge.NextInAEL)
			{
				tEdge.PrevInSEL = tEdge.PrevInAEL;
				tEdge.NextInSEL = tEdge.NextInAEL;
			}
		}

		private void SwapPositionsInSEL(TEdge edge1, TEdge edge2)
		{
			if ((edge1.NextInSEL == null && edge1.PrevInSEL == null) || (edge2.NextInSEL == null && edge2.PrevInSEL == null))
			{
				return;
			}
			if (edge1.NextInSEL == edge2)
			{
				TEdge nextInSEL = edge2.NextInSEL;
				if (nextInSEL != null)
				{
					nextInSEL.PrevInSEL = edge1;
				}
				TEdge prevInSEL = edge1.PrevInSEL;
				if (prevInSEL != null)
				{
					prevInSEL.NextInSEL = edge2;
				}
				edge2.PrevInSEL = prevInSEL;
				edge2.NextInSEL = edge1;
				edge1.PrevInSEL = edge2;
				edge1.NextInSEL = nextInSEL;
			}
			else if (edge2.NextInSEL == edge1)
			{
				TEdge nextInSEL2 = edge1.NextInSEL;
				if (nextInSEL2 != null)
				{
					nextInSEL2.PrevInSEL = edge2;
				}
				TEdge prevInSEL2 = edge2.PrevInSEL;
				if (prevInSEL2 != null)
				{
					prevInSEL2.NextInSEL = edge1;
				}
				edge1.PrevInSEL = prevInSEL2;
				edge1.NextInSEL = edge2;
				edge2.PrevInSEL = edge1;
				edge2.NextInSEL = nextInSEL2;
			}
			else
			{
				TEdge nextInSEL3 = edge1.NextInSEL;
				TEdge prevInSEL3 = edge1.PrevInSEL;
				edge1.NextInSEL = edge2.NextInSEL;
				if (edge1.NextInSEL != null)
				{
					edge1.NextInSEL.PrevInSEL = edge1;
				}
				edge1.PrevInSEL = edge2.PrevInSEL;
				if (edge1.PrevInSEL != null)
				{
					edge1.PrevInSEL.NextInSEL = edge1;
				}
				edge2.NextInSEL = nextInSEL3;
				if (edge2.NextInSEL != null)
				{
					edge2.NextInSEL.PrevInSEL = edge2;
				}
				edge2.PrevInSEL = prevInSEL3;
				if (edge2.PrevInSEL != null)
				{
					edge2.PrevInSEL.NextInSEL = edge2;
				}
			}
			if (edge1.PrevInSEL == null)
			{
				m_SortedEdges = edge1;
			}
			else if (edge2.PrevInSEL == null)
			{
				m_SortedEdges = edge2;
			}
		}

		private void AddLocalMaxPoly(TEdge e1, TEdge e2, IntPoint pt)
		{
			AddOutPt(e1, pt);
			if (e2.WindDelta == 0)
			{
				AddOutPt(e2, pt);
			}
			if (e1.OutIdx == e2.OutIdx)
			{
				e1.OutIdx = -1;
				e2.OutIdx = -1;
			}
			else if (e1.OutIdx < e2.OutIdx)
			{
				AppendPolygon(e1, e2);
			}
			else
			{
				AppendPolygon(e2, e1);
			}
		}

		private OutPt AddLocalMinPoly(TEdge e1, TEdge e2, IntPoint pt)
		{
			OutPt outPt;
			TEdge tEdge;
			TEdge tEdge2;
			if (ClipperBase.IsHorizontal(e2) || e1.Dx > e2.Dx)
			{
				outPt = AddOutPt(e1, pt);
				e2.OutIdx = e1.OutIdx;
				e1.Side = EdgeSide.esLeft;
				e2.Side = EdgeSide.esRight;
				tEdge = e1;
				tEdge2 = ((tEdge.PrevInAEL != e2) ? tEdge.PrevInAEL : e2.PrevInAEL);
			}
			else
			{
				outPt = AddOutPt(e2, pt);
				e1.OutIdx = e2.OutIdx;
				e1.Side = EdgeSide.esRight;
				e2.Side = EdgeSide.esLeft;
				tEdge = e2;
				tEdge2 = ((tEdge.PrevInAEL != e1) ? tEdge.PrevInAEL : e1.PrevInAEL);
			}
			if (tEdge2 != null && tEdge2.OutIdx >= 0 && tEdge2.Top.Y < pt.Y && tEdge.Top.Y < pt.Y)
			{
				long num = TopX(tEdge2, pt.Y);
				long num2 = TopX(tEdge, pt.Y);
				if (num == num2 && tEdge.WindDelta != 0 && tEdge2.WindDelta != 0 && ClipperBase.SlopesEqual(new IntPoint(num, pt.Y), tEdge2.Top, new IntPoint(num2, pt.Y), tEdge.Top, m_UseFullRange))
				{
					OutPt op = AddOutPt(tEdge2, pt);
					AddJoin(outPt, op, tEdge.Top);
				}
			}
			return outPt;
		}

		private OutPt AddOutPt(TEdge e, IntPoint pt)
		{
			if (e.OutIdx < 0)
			{
				OutRec outRec = CreateOutRec();
				outRec.IsOpen = e.WindDelta == 0;
				OutPt outPt = (outRec.Pts = new OutPt());
				outPt.Idx = outRec.Idx;
				outPt.Pt = pt;
				outPt.Next = outPt;
				outPt.Prev = outPt;
				if (!outRec.IsOpen)
				{
					SetHoleState(e, outRec);
				}
				e.OutIdx = outRec.Idx;
				return outPt;
			}
			OutRec outRec2 = m_PolyOuts[e.OutIdx];
			OutPt pts = outRec2.Pts;
			bool flag = e.Side == EdgeSide.esLeft;
			if (flag && pt == pts.Pt)
			{
				return pts;
			}
			if (!flag && pt == pts.Prev.Pt)
			{
				return pts.Prev;
			}
			OutPt outPt2 = new OutPt();
			outPt2.Idx = outRec2.Idx;
			outPt2.Pt = pt;
			outPt2.Next = pts;
			outPt2.Prev = pts.Prev;
			outPt2.Prev.Next = outPt2;
			pts.Prev = outPt2;
			if (flag)
			{
				outRec2.Pts = outPt2;
			}
			return outPt2;
		}

		private OutPt GetLastOutPt(TEdge e)
		{
			OutRec outRec = m_PolyOuts[e.OutIdx];
			if (e.Side == EdgeSide.esLeft)
			{
				return outRec.Pts;
			}
			return outRec.Pts.Prev;
		}

		internal void SwapPoints(ref IntPoint pt1, ref IntPoint pt2)
		{
			IntPoint intPoint = new IntPoint(pt1);
			pt1 = pt2;
			pt2 = intPoint;
		}

		private bool HorzSegmentsOverlap(long seg1a, long seg1b, long seg2a, long seg2b)
		{
			if (seg1a > seg1b)
			{
				Swap(ref seg1a, ref seg1b);
			}
			if (seg2a > seg2b)
			{
				Swap(ref seg2a, ref seg2b);
			}
			if (seg1a < seg2b)
			{
				return seg2a < seg1b;
			}
			return false;
		}

		private void SetHoleState(TEdge e, OutRec outRec)
		{
			TEdge prevInAEL = e.PrevInAEL;
			TEdge tEdge = null;
			while (prevInAEL != null)
			{
				if (prevInAEL.OutIdx >= 0 && prevInAEL.WindDelta != 0)
				{
					if (tEdge == null)
					{
						tEdge = prevInAEL;
					}
					else if (tEdge.OutIdx == prevInAEL.OutIdx)
					{
						tEdge = null;
					}
				}
				prevInAEL = prevInAEL.PrevInAEL;
			}
			if (tEdge == null)
			{
				outRec.FirstLeft = null;
				outRec.IsHole = false;
			}
			else
			{
				outRec.FirstLeft = m_PolyOuts[tEdge.OutIdx];
				outRec.IsHole = !outRec.FirstLeft.IsHole;
			}
		}

		private double GetDx(IntPoint pt1, IntPoint pt2)
		{
			if (pt1.Y == pt2.Y)
			{
				return -3.4E+38;
			}
			return (double)(pt2.X - pt1.X) / (double)(pt2.Y - pt1.Y);
		}

		private bool FirstIsBottomPt(OutPt btmPt1, OutPt btmPt2)
		{
			OutPt prev = btmPt1.Prev;
			while (prev.Pt == btmPt1.Pt && prev != btmPt1)
			{
				prev = prev.Prev;
			}
			double num = Math.Abs(GetDx(btmPt1.Pt, prev.Pt));
			prev = btmPt1.Next;
			while (prev.Pt == btmPt1.Pt && prev != btmPt1)
			{
				prev = prev.Next;
			}
			double num2 = Math.Abs(GetDx(btmPt1.Pt, prev.Pt));
			prev = btmPt2.Prev;
			while (prev.Pt == btmPt2.Pt && prev != btmPt2)
			{
				prev = prev.Prev;
			}
			double num3 = Math.Abs(GetDx(btmPt2.Pt, prev.Pt));
			prev = btmPt2.Next;
			while (prev.Pt == btmPt2.Pt && prev != btmPt2)
			{
				prev = prev.Next;
			}
			double num4 = Math.Abs(GetDx(btmPt2.Pt, prev.Pt));
			if (Math.Max(num, num2) == Math.Max(num3, num4) && Math.Min(num, num2) == Math.Min(num3, num4))
			{
				return Area(btmPt1) > 0.0;
			}
			if (!(num >= num3) || !(num >= num4))
			{
				if (num2 >= num3)
				{
					return num2 >= num4;
				}
				return false;
			}
			return true;
		}

		private OutPt GetBottomPt(OutPt pp)
		{
			OutPt outPt = null;
			OutPt next;
			for (next = pp.Next; next != pp; next = next.Next)
			{
				if (next.Pt.Y > pp.Pt.Y)
				{
					pp = next;
					outPt = null;
				}
				else if (next.Pt.Y == pp.Pt.Y && next.Pt.X <= pp.Pt.X)
				{
					if (next.Pt.X < pp.Pt.X)
					{
						outPt = null;
						pp = next;
					}
					else if (next.Next != pp && next.Prev != pp)
					{
						outPt = next;
					}
				}
			}
			if (outPt != null)
			{
				while (outPt != next)
				{
					if (!FirstIsBottomPt(next, outPt))
					{
						pp = outPt;
					}
					outPt = outPt.Next;
					while (outPt.Pt != pp.Pt)
					{
						outPt = outPt.Next;
					}
				}
			}
			return pp;
		}

		private OutRec GetLowermostRec(OutRec outRec1, OutRec outRec2)
		{
			if (outRec1.BottomPt == null)
			{
				outRec1.BottomPt = GetBottomPt(outRec1.Pts);
			}
			if (outRec2.BottomPt == null)
			{
				outRec2.BottomPt = GetBottomPt(outRec2.Pts);
			}
			OutPt bottomPt = outRec1.BottomPt;
			OutPt bottomPt2 = outRec2.BottomPt;
			if (bottomPt.Pt.Y > bottomPt2.Pt.Y)
			{
				return outRec1;
			}
			if (bottomPt.Pt.Y < bottomPt2.Pt.Y)
			{
				return outRec2;
			}
			if (bottomPt.Pt.X < bottomPt2.Pt.X)
			{
				return outRec1;
			}
			if (bottomPt.Pt.X > bottomPt2.Pt.X)
			{
				return outRec2;
			}
			if (bottomPt.Next == bottomPt)
			{
				return outRec2;
			}
			if (bottomPt2.Next == bottomPt2)
			{
				return outRec1;
			}
			if (FirstIsBottomPt(bottomPt, bottomPt2))
			{
				return outRec1;
			}
			return outRec2;
		}

		private bool OutRec1RightOfOutRec2(OutRec outRec1, OutRec outRec2)
		{
			do
			{
				outRec1 = outRec1.FirstLeft;
				if (outRec1 == outRec2)
				{
					return true;
				}
			}
			while (outRec1 != null);
			return false;
		}

		private OutRec GetOutRec(int idx)
		{
			OutRec outRec;
			for (outRec = m_PolyOuts[idx]; outRec != m_PolyOuts[outRec.Idx]; outRec = m_PolyOuts[outRec.Idx])
			{
			}
			return outRec;
		}

		private void AppendPolygon(TEdge e1, TEdge e2)
		{
			OutRec outRec = m_PolyOuts[e1.OutIdx];
			OutRec outRec2 = m_PolyOuts[e2.OutIdx];
			OutRec outRec3 = (OutRec1RightOfOutRec2(outRec, outRec2) ? outRec2 : ((!OutRec1RightOfOutRec2(outRec2, outRec)) ? GetLowermostRec(outRec, outRec2) : outRec));
			OutPt pts = outRec.Pts;
			OutPt prev = pts.Prev;
			OutPt pts2 = outRec2.Pts;
			OutPt prev2 = pts2.Prev;
			if (e1.Side == EdgeSide.esLeft)
			{
				if (e2.Side == EdgeSide.esLeft)
				{
					ReversePolyPtLinks(pts2);
					pts2.Next = pts;
					pts.Prev = pts2;
					prev.Next = prev2;
					prev2.Prev = prev;
					outRec.Pts = prev2;
				}
				else
				{
					prev2.Next = pts;
					pts.Prev = prev2;
					pts2.Prev = prev;
					prev.Next = pts2;
					outRec.Pts = pts2;
				}
			}
			else if (e2.Side == EdgeSide.esRight)
			{
				ReversePolyPtLinks(pts2);
				prev.Next = prev2;
				prev2.Prev = prev;
				pts2.Next = pts;
				pts.Prev = pts2;
			}
			else
			{
				prev.Next = pts2;
				pts2.Prev = prev;
				pts.Prev = prev2;
				prev2.Next = pts;
			}
			outRec.BottomPt = null;
			if (outRec3 == outRec2)
			{
				if (outRec2.FirstLeft != outRec)
				{
					outRec.FirstLeft = outRec2.FirstLeft;
				}
				outRec.IsHole = outRec2.IsHole;
			}
			outRec2.Pts = null;
			outRec2.BottomPt = null;
			outRec2.FirstLeft = outRec;
			int outIdx = e1.OutIdx;
			int outIdx2 = e2.OutIdx;
			e1.OutIdx = -1;
			e2.OutIdx = -1;
			for (TEdge tEdge = m_ActiveEdges; tEdge != null; tEdge = tEdge.NextInAEL)
			{
				if (tEdge.OutIdx == outIdx2)
				{
					tEdge.OutIdx = outIdx;
					tEdge.Side = e1.Side;
					break;
				}
			}
			outRec2.Idx = outRec.Idx;
		}

		private void ReversePolyPtLinks(OutPt pp)
		{
			if (pp != null)
			{
				OutPt outPt = pp;
				do
				{
					OutPt next = outPt.Next;
					outPt.Next = outPt.Prev;
					outPt.Prev = next;
					outPt = next;
				}
				while (outPt != pp);
			}
		}

		private static void SwapSides(TEdge edge1, TEdge edge2)
		{
			EdgeSide side = edge1.Side;
			edge1.Side = edge2.Side;
			edge2.Side = side;
		}

		private static void SwapPolyIndexes(TEdge edge1, TEdge edge2)
		{
			int outIdx = edge1.OutIdx;
			edge1.OutIdx = edge2.OutIdx;
			edge2.OutIdx = outIdx;
		}

		private void IntersectEdges(TEdge e1, TEdge e2, IntPoint pt)
		{
			bool flag = e1.OutIdx >= 0;
			bool flag2 = e2.OutIdx >= 0;
			if (e1.WindDelta == 0 || e2.WindDelta == 0)
			{
				if (e1.WindDelta == 0 && e2.WindDelta == 0)
				{
					return;
				}
				if (e1.PolyTyp == e2.PolyTyp && e1.WindDelta != e2.WindDelta && m_ClipType == ClipType.ctUnion)
				{
					if (e1.WindDelta == 0)
					{
						if (flag2)
						{
							AddOutPt(e1, pt);
							if (flag)
							{
								e1.OutIdx = -1;
							}
						}
					}
					else if (flag)
					{
						AddOutPt(e2, pt);
						if (flag2)
						{
							e2.OutIdx = -1;
						}
					}
				}
				else
				{
					if (e1.PolyTyp == e2.PolyTyp)
					{
						return;
					}
					if (e1.WindDelta == 0 && Math.Abs(e2.WindCnt) == 1 && (m_ClipType != ClipType.ctUnion || e2.WindCnt2 == 0))
					{
						AddOutPt(e1, pt);
						if (flag)
						{
							e1.OutIdx = -1;
						}
					}
					else if (e2.WindDelta == 0 && Math.Abs(e1.WindCnt) == 1 && (m_ClipType != ClipType.ctUnion || e1.WindCnt2 == 0))
					{
						AddOutPt(e2, pt);
						if (flag2)
						{
							e2.OutIdx = -1;
						}
					}
				}
				return;
			}
			if (e1.PolyTyp == e2.PolyTyp)
			{
				if (IsEvenOddFillType(e1))
				{
					int windCnt = e1.WindCnt;
					e1.WindCnt = e2.WindCnt;
					e2.WindCnt = windCnt;
				}
				else
				{
					if (e1.WindCnt + e2.WindDelta == 0)
					{
						e1.WindCnt = -e1.WindCnt;
					}
					else
					{
						e1.WindCnt += e2.WindDelta;
					}
					if (e2.WindCnt - e1.WindDelta == 0)
					{
						e2.WindCnt = -e2.WindCnt;
					}
					else
					{
						e2.WindCnt -= e1.WindDelta;
					}
				}
			}
			else
			{
				if (!IsEvenOddFillType(e2))
				{
					e1.WindCnt2 += e2.WindDelta;
				}
				else
				{
					e1.WindCnt2 = ((e1.WindCnt2 == 0) ? 1 : 0);
				}
				if (!IsEvenOddFillType(e1))
				{
					e2.WindCnt2 -= e1.WindDelta;
				}
				else
				{
					e2.WindCnt2 = ((e2.WindCnt2 == 0) ? 1 : 0);
				}
			}
			PolyFillType polyFillType;
			PolyFillType polyFillType2;
			if (e1.PolyTyp == PolyType.ptSubject)
			{
				polyFillType = m_SubjFillType;
				polyFillType2 = m_ClipFillType;
			}
			else
			{
				polyFillType = m_ClipFillType;
				polyFillType2 = m_SubjFillType;
			}
			PolyFillType polyFillType3;
			PolyFillType polyFillType4;
			if (e2.PolyTyp == PolyType.ptSubject)
			{
				polyFillType3 = m_SubjFillType;
				polyFillType4 = m_ClipFillType;
			}
			else
			{
				polyFillType3 = m_ClipFillType;
				polyFillType4 = m_SubjFillType;
			}
			int num = polyFillType switch
			{
				PolyFillType.pftPositive => e1.WindCnt, 
				PolyFillType.pftNegative => -e1.WindCnt, 
				_ => Math.Abs(e1.WindCnt), 
			};
			int num2 = polyFillType3 switch
			{
				PolyFillType.pftPositive => e2.WindCnt, 
				PolyFillType.pftNegative => -e2.WindCnt, 
				_ => Math.Abs(e2.WindCnt), 
			};
			if (flag & flag2)
			{
				if ((num != 0 && num != 1) || (num2 != 0 && num2 != 1) || (e1.PolyTyp != e2.PolyTyp && m_ClipType != ClipType.ctXor))
				{
					AddLocalMaxPoly(e1, e2, pt);
					return;
				}
				AddOutPt(e1, pt);
				AddOutPt(e2, pt);
				SwapSides(e1, e2);
				SwapPolyIndexes(e1, e2);
			}
			else if (flag)
			{
				if (num2 == 0 || num2 == 1)
				{
					AddOutPt(e1, pt);
					SwapSides(e1, e2);
					SwapPolyIndexes(e1, e2);
				}
			}
			else if (flag2)
			{
				if (num == 0 || num == 1)
				{
					AddOutPt(e2, pt);
					SwapSides(e1, e2);
					SwapPolyIndexes(e1, e2);
				}
			}
			else
			{
				if ((num != 0 && num != 1) || (num2 != 0 && num2 != 1))
				{
					return;
				}
				long num3 = polyFillType2 switch
				{
					PolyFillType.pftPositive => e1.WindCnt2, 
					PolyFillType.pftNegative => -e1.WindCnt2, 
					_ => Math.Abs(e1.WindCnt2), 
				};
				long num4 = polyFillType4 switch
				{
					PolyFillType.pftPositive => e2.WindCnt2, 
					PolyFillType.pftNegative => -e2.WindCnt2, 
					_ => Math.Abs(e2.WindCnt2), 
				};
				if (e1.PolyTyp != e2.PolyTyp)
				{
					AddLocalMinPoly(e1, e2, pt);
				}
				else if (num == 1 && num2 == 1)
				{
					switch (m_ClipType)
					{
					case ClipType.ctIntersection:
						if (num3 > 0 && num4 > 0)
						{
							AddLocalMinPoly(e1, e2, pt);
						}
						break;
					case ClipType.ctUnion:
						if (num3 <= 0 && num4 <= 0)
						{
							AddLocalMinPoly(e1, e2, pt);
						}
						break;
					case ClipType.ctDifference:
						if ((e1.PolyTyp == PolyType.ptClip && num3 > 0 && num4 > 0) || (e1.PolyTyp == PolyType.ptSubject && num3 <= 0 && num4 <= 0))
						{
							AddLocalMinPoly(e1, e2, pt);
						}
						break;
					case ClipType.ctXor:
						AddLocalMinPoly(e1, e2, pt);
						break;
					}
				}
				else
				{
					SwapSides(e1, e2);
				}
			}
		}

		private void DeleteFromSEL(TEdge e)
		{
			TEdge prevInSEL = e.PrevInSEL;
			TEdge nextInSEL = e.NextInSEL;
			if (prevInSEL != null || nextInSEL != null || e == m_SortedEdges)
			{
				if (prevInSEL != null)
				{
					prevInSEL.NextInSEL = nextInSEL;
				}
				else
				{
					m_SortedEdges = nextInSEL;
				}
				if (nextInSEL != null)
				{
					nextInSEL.PrevInSEL = prevInSEL;
				}
				e.NextInSEL = null;
				e.PrevInSEL = null;
			}
		}

		private void ProcessHorizontals()
		{
			TEdge e;
			while (PopEdgeFromSEL(out e))
			{
				ProcessHorizontal(e);
			}
		}

		private void GetHorzDirection(TEdge HorzEdge, out Direction Dir, out long Left, out long Right)
		{
			if (HorzEdge.Bot.X < HorzEdge.Top.X)
			{
				Left = HorzEdge.Bot.X;
				Right = HorzEdge.Top.X;
				Dir = Direction.dLeftToRight;
			}
			else
			{
				Left = HorzEdge.Top.X;
				Right = HorzEdge.Bot.X;
				Dir = Direction.dRightToLeft;
			}
		}

		private void ProcessHorizontal(TEdge horzEdge)
		{
			bool flag = horzEdge.WindDelta == 0;
			GetHorzDirection(horzEdge, out var Dir, out var Left, out var Right);
			TEdge tEdge = horzEdge;
			TEdge tEdge2 = null;
			while (tEdge.NextInLML != null && ClipperBase.IsHorizontal(tEdge.NextInLML))
			{
				tEdge = tEdge.NextInLML;
			}
			if (tEdge.NextInLML == null)
			{
				tEdge2 = GetMaximaPair(tEdge);
			}
			Maxima maxima = m_Maxima;
			if (maxima != null)
			{
				if (Dir == Direction.dLeftToRight)
				{
					while (maxima != null && maxima.X <= horzEdge.Bot.X)
					{
						maxima = maxima.Next;
					}
					if (maxima != null && maxima.X >= tEdge.Top.X)
					{
						maxima = null;
					}
				}
				else
				{
					while (maxima.Next != null && maxima.Next.X < horzEdge.Bot.X)
					{
						maxima = maxima.Next;
					}
					if (maxima.X <= tEdge.Top.X)
					{
						maxima = null;
					}
				}
			}
			OutPt outPt = null;
			while (true)
			{
				bool flag2 = horzEdge == tEdge;
				TEdge tEdge3 = GetNextInAEL(horzEdge, Dir);
				while (tEdge3 != null)
				{
					if (maxima != null)
					{
						if (Dir == Direction.dLeftToRight)
						{
							while (maxima != null && maxima.X < tEdge3.Curr.X)
							{
								if (horzEdge.OutIdx >= 0 && !flag)
								{
									AddOutPt(horzEdge, new IntPoint(maxima.X, horzEdge.Bot.Y));
								}
								maxima = maxima.Next;
							}
						}
						else
						{
							while (maxima != null && maxima.X > tEdge3.Curr.X)
							{
								if (horzEdge.OutIdx >= 0 && !flag)
								{
									AddOutPt(horzEdge, new IntPoint(maxima.X, horzEdge.Bot.Y));
								}
								maxima = maxima.Prev;
							}
						}
					}
					if ((Dir == Direction.dLeftToRight && tEdge3.Curr.X > Right) || (Dir == Direction.dRightToLeft && tEdge3.Curr.X < Left) || (tEdge3.Curr.X == horzEdge.Top.X && horzEdge.NextInLML != null && tEdge3.Dx < horzEdge.NextInLML.Dx))
					{
						break;
					}
					if (horzEdge.OutIdx >= 0 && !flag)
					{
						outPt = AddOutPt(horzEdge, tEdge3.Curr);
						for (TEdge tEdge4 = m_SortedEdges; tEdge4 != null; tEdge4 = tEdge4.NextInSEL)
						{
							if (tEdge4.OutIdx >= 0 && HorzSegmentsOverlap(horzEdge.Bot.X, horzEdge.Top.X, tEdge4.Bot.X, tEdge4.Top.X))
							{
								OutPt lastOutPt = GetLastOutPt(tEdge4);
								AddJoin(lastOutPt, outPt, tEdge4.Top);
							}
						}
						AddGhostJoin(outPt, horzEdge.Bot);
					}
					if ((tEdge3 == tEdge2) & flag2)
					{
						if (horzEdge.OutIdx >= 0)
						{
							AddLocalMaxPoly(horzEdge, tEdge2, horzEdge.Top);
						}
						DeleteFromAEL(horzEdge);
						DeleteFromAEL(tEdge2);
						return;
					}
					if (Dir == Direction.dLeftToRight)
					{
						IntersectEdges(pt: new IntPoint(tEdge3.Curr.X, horzEdge.Curr.Y), e1: horzEdge, e2: tEdge3);
					}
					else
					{
						IntersectEdges(pt: new IntPoint(tEdge3.Curr.X, horzEdge.Curr.Y), e1: tEdge3, e2: horzEdge);
					}
					TEdge nextInAEL = GetNextInAEL(tEdge3, Dir);
					SwapPositionsInAEL(horzEdge, tEdge3);
					tEdge3 = nextInAEL;
				}
				if (horzEdge.NextInLML == null || !ClipperBase.IsHorizontal(horzEdge.NextInLML))
				{
					break;
				}
				UpdateEdgeIntoAEL(ref horzEdge);
				if (horzEdge.OutIdx >= 0)
				{
					AddOutPt(horzEdge, horzEdge.Bot);
				}
				GetHorzDirection(horzEdge, out Dir, out Left, out Right);
			}
			if (horzEdge.OutIdx >= 0 && outPt == null)
			{
				outPt = GetLastOutPt(horzEdge);
				for (TEdge tEdge5 = m_SortedEdges; tEdge5 != null; tEdge5 = tEdge5.NextInSEL)
				{
					if (tEdge5.OutIdx >= 0 && HorzSegmentsOverlap(horzEdge.Bot.X, horzEdge.Top.X, tEdge5.Bot.X, tEdge5.Top.X))
					{
						OutPt lastOutPt2 = GetLastOutPt(tEdge5);
						AddJoin(lastOutPt2, outPt, tEdge5.Top);
					}
				}
				AddGhostJoin(outPt, horzEdge.Top);
			}
			if (horzEdge.NextInLML != null)
			{
				if (horzEdge.OutIdx >= 0)
				{
					outPt = AddOutPt(horzEdge, horzEdge.Top);
					UpdateEdgeIntoAEL(ref horzEdge);
					if (horzEdge.WindDelta != 0)
					{
						TEdge prevInAEL = horzEdge.PrevInAEL;
						TEdge nextInAEL2 = horzEdge.NextInAEL;
						if (prevInAEL != null && prevInAEL.Curr.X == horzEdge.Bot.X && prevInAEL.Curr.Y == horzEdge.Bot.Y && prevInAEL.WindDelta != 0 && prevInAEL.OutIdx >= 0 && prevInAEL.Curr.Y > prevInAEL.Top.Y && ClipperBase.SlopesEqual(horzEdge, prevInAEL, m_UseFullRange))
						{
							OutPt op = AddOutPt(prevInAEL, horzEdge.Bot);
							AddJoin(outPt, op, horzEdge.Top);
						}
						else if (nextInAEL2 != null && nextInAEL2.Curr.X == horzEdge.Bot.X && nextInAEL2.Curr.Y == horzEdge.Bot.Y && nextInAEL2.WindDelta != 0 && nextInAEL2.OutIdx >= 0 && nextInAEL2.Curr.Y > nextInAEL2.Top.Y && ClipperBase.SlopesEqual(horzEdge, nextInAEL2, m_UseFullRange))
						{
							OutPt op2 = AddOutPt(nextInAEL2, horzEdge.Bot);
							AddJoin(outPt, op2, horzEdge.Top);
						}
					}
				}
				else
				{
					UpdateEdgeIntoAEL(ref horzEdge);
				}
			}
			else
			{
				if (horzEdge.OutIdx >= 0)
				{
					AddOutPt(horzEdge, horzEdge.Top);
				}
				DeleteFromAEL(horzEdge);
			}
		}

		private TEdge GetNextInAEL(TEdge e, Direction Direction)
		{
			if (Direction != Direction.dLeftToRight)
			{
				return e.PrevInAEL;
			}
			return e.NextInAEL;
		}

		private bool IsMinima(TEdge e)
		{
			if (e != null && e.Prev.NextInLML != e)
			{
				return e.Next.NextInLML != e;
			}
			return false;
		}

		private bool IsMaxima(TEdge e, double Y)
		{
			if (e != null && (double)e.Top.Y == Y)
			{
				return e.NextInLML == null;
			}
			return false;
		}

		private bool IsIntermediate(TEdge e, double Y)
		{
			if ((double)e.Top.Y == Y)
			{
				return e.NextInLML != null;
			}
			return false;
		}

		internal TEdge GetMaximaPair(TEdge e)
		{
			if (e.Next.Top == e.Top && e.Next.NextInLML == null)
			{
				return e.Next;
			}
			if (e.Prev.Top == e.Top && e.Prev.NextInLML == null)
			{
				return e.Prev;
			}
			return null;
		}

		internal TEdge GetMaximaPairEx(TEdge e)
		{
			TEdge maximaPair = GetMaximaPair(e);
			if (maximaPair == null || maximaPair.OutIdx == -2 || (maximaPair.NextInAEL == maximaPair.PrevInAEL && !ClipperBase.IsHorizontal(maximaPair)))
			{
				return null;
			}
			return maximaPair;
		}

		private bool ProcessIntersections(long topY)
		{
			if (m_ActiveEdges == null)
			{
				return true;
			}
			try
			{
				BuildIntersectList(topY);
				if (m_IntersectList.Count == 0)
				{
					return true;
				}
				if (m_IntersectList.Count != 1 && !FixupIntersectionOrder())
				{
					return false;
				}
				ProcessIntersectList();
			}
			catch
			{
				m_SortedEdges = null;
				m_IntersectList.Clear();
				throw new ClipperException("ProcessIntersections error");
			}
			m_SortedEdges = null;
			return true;
		}

		private void BuildIntersectList(long topY)
		{
			if (m_ActiveEdges == null)
			{
				return;
			}
			for (TEdge tEdge = (m_SortedEdges = m_ActiveEdges); tEdge != null; tEdge = tEdge.NextInAEL)
			{
				tEdge.PrevInSEL = tEdge.PrevInAEL;
				tEdge.NextInSEL = tEdge.NextInAEL;
				tEdge.Curr.X = TopX(tEdge, topY);
			}
			bool flag = true;
			while (flag && m_SortedEdges != null)
			{
				flag = false;
				TEdge tEdge = m_SortedEdges;
				while (tEdge.NextInSEL != null)
				{
					TEdge nextInSEL = tEdge.NextInSEL;
					if (tEdge.Curr.X > nextInSEL.Curr.X)
					{
						IntersectPoint(tEdge, nextInSEL, out var ip);
						if (ip.Y < topY)
						{
							ip = new IntPoint(TopX(tEdge, topY), topY);
						}
						IntersectNode intersectNode = new IntersectNode();
						intersectNode.Edge1 = tEdge;
						intersectNode.Edge2 = nextInSEL;
						intersectNode.Pt = ip;
						m_IntersectList.Add(intersectNode);
						SwapPositionsInSEL(tEdge, nextInSEL);
						flag = true;
					}
					else
					{
						tEdge = nextInSEL;
					}
				}
				if (tEdge.PrevInSEL == null)
				{
					break;
				}
				tEdge.PrevInSEL.NextInSEL = null;
			}
			m_SortedEdges = null;
		}

		private bool EdgesAdjacent(IntersectNode inode)
		{
			if (inode.Edge1.NextInSEL != inode.Edge2)
			{
				return inode.Edge1.PrevInSEL == inode.Edge2;
			}
			return true;
		}

		private static int IntersectNodeSort(IntersectNode node1, IntersectNode node2)
		{
			return (int)(node2.Pt.Y - node1.Pt.Y);
		}

		private bool FixupIntersectionOrder()
		{
			m_IntersectList.Sort(m_IntersectNodeComparer);
			CopyAELToSEL();
			int count = m_IntersectList.Count;
			for (int i = 0; i < count; i++)
			{
				if (!EdgesAdjacent(m_IntersectList[i]))
				{
					int j;
					for (j = i + 1; j < count && !EdgesAdjacent(m_IntersectList[j]); j++)
					{
					}
					if (j == count)
					{
						return false;
					}
					IntersectNode value = m_IntersectList[i];
					m_IntersectList[i] = m_IntersectList[j];
					m_IntersectList[j] = value;
				}
				SwapPositionsInSEL(m_IntersectList[i].Edge1, m_IntersectList[i].Edge2);
			}
			return true;
		}

		private void ProcessIntersectList()
		{
			for (int i = 0; i < m_IntersectList.Count; i++)
			{
				IntersectNode intersectNode = m_IntersectList[i];
				IntersectEdges(intersectNode.Edge1, intersectNode.Edge2, intersectNode.Pt);
				SwapPositionsInAEL(intersectNode.Edge1, intersectNode.Edge2);
			}
			m_IntersectList.Clear();
		}

		internal static long Round(double value)
		{
			if (!(value < 0.0))
			{
				return (long)(value + 0.5);
			}
			return (long)(value - 0.5);
		}

		private static long TopX(TEdge edge, long currentY)
		{
			if (currentY == edge.Top.Y)
			{
				return edge.Top.X;
			}
			return edge.Bot.X + Round(edge.Dx * (double)(currentY - edge.Bot.Y));
		}

		private void IntersectPoint(TEdge edge1, TEdge edge2, out IntPoint ip)
		{
			ip = default(IntPoint);
			if (edge1.Dx == edge2.Dx)
			{
				ip.Y = edge1.Curr.Y;
				ip.X = TopX(edge1, ip.Y);
				return;
			}
			if (edge1.Delta.X == 0L)
			{
				ip.X = edge1.Bot.X;
				if (ClipperBase.IsHorizontal(edge2))
				{
					ip.Y = edge2.Bot.Y;
				}
				else
				{
					double num = (double)edge2.Bot.Y - (double)edge2.Bot.X / edge2.Dx;
					ip.Y = Round((double)ip.X / edge2.Dx + num);
				}
			}
			else if (edge2.Delta.X == 0L)
			{
				ip.X = edge2.Bot.X;
				if (ClipperBase.IsHorizontal(edge1))
				{
					ip.Y = edge1.Bot.Y;
				}
				else
				{
					double num2 = (double)edge1.Bot.Y - (double)edge1.Bot.X / edge1.Dx;
					ip.Y = Round((double)ip.X / edge1.Dx + num2);
				}
			}
			else
			{
				double num2 = (double)edge1.Bot.X - (double)edge1.Bot.Y * edge1.Dx;
				double num = (double)edge2.Bot.X - (double)edge2.Bot.Y * edge2.Dx;
				double num3 = (num - num2) / (edge1.Dx - edge2.Dx);
				ip.Y = Round(num3);
				if (Math.Abs(edge1.Dx) < Math.Abs(edge2.Dx))
				{
					ip.X = Round(edge1.Dx * num3 + num2);
				}
				else
				{
					ip.X = Round(edge2.Dx * num3 + num);
				}
			}
			if (ip.Y < edge1.Top.Y || ip.Y < edge2.Top.Y)
			{
				if (edge1.Top.Y > edge2.Top.Y)
				{
					ip.Y = edge1.Top.Y;
				}
				else
				{
					ip.Y = edge2.Top.Y;
				}
				if (Math.Abs(edge1.Dx) < Math.Abs(edge2.Dx))
				{
					ip.X = TopX(edge1, ip.Y);
				}
				else
				{
					ip.X = TopX(edge2, ip.Y);
				}
			}
			if (ip.Y > edge1.Curr.Y)
			{
				ip.Y = edge1.Curr.Y;
				if (Math.Abs(edge1.Dx) > Math.Abs(edge2.Dx))
				{
					ip.X = TopX(edge2, ip.Y);
				}
				else
				{
					ip.X = TopX(edge1, ip.Y);
				}
			}
		}

		private void ProcessEdgesAtTopOfScanbeam(long topY)
		{
			TEdge e = m_ActiveEdges;
			while (e != null)
			{
				bool flag = IsMaxima(e, topY);
				if (flag)
				{
					TEdge maximaPairEx = GetMaximaPairEx(e);
					flag = maximaPairEx == null || !ClipperBase.IsHorizontal(maximaPairEx);
				}
				if (flag)
				{
					if (StrictlySimple)
					{
						InsertMaxima(e.Top.X);
					}
					TEdge prevInAEL = e.PrevInAEL;
					DoMaxima(e);
					e = ((prevInAEL != null) ? prevInAEL.NextInAEL : m_ActiveEdges);
					continue;
				}
				if (IsIntermediate(e, topY) && ClipperBase.IsHorizontal(e.NextInLML))
				{
					UpdateEdgeIntoAEL(ref e);
					if (e.OutIdx >= 0)
					{
						AddOutPt(e, e.Bot);
					}
					AddEdgeToSEL(e);
				}
				else
				{
					e.Curr.X = TopX(e, topY);
					e.Curr.Y = topY;
				}
				if (StrictlySimple)
				{
					TEdge prevInAEL2 = e.PrevInAEL;
					if (e.OutIdx >= 0 && e.WindDelta != 0 && prevInAEL2 != null && prevInAEL2.OutIdx >= 0 && prevInAEL2.Curr.X == e.Curr.X && prevInAEL2.WindDelta != 0)
					{
						IntPoint intPoint = new IntPoint(e.Curr);
						OutPt op = AddOutPt(prevInAEL2, intPoint);
						OutPt op2 = AddOutPt(e, intPoint);
						AddJoin(op, op2, intPoint);
					}
				}
				e = e.NextInAEL;
			}
			ProcessHorizontals();
			m_Maxima = null;
			for (e = m_ActiveEdges; e != null; e = e.NextInAEL)
			{
				if (IsIntermediate(e, topY))
				{
					OutPt outPt = null;
					if (e.OutIdx >= 0)
					{
						outPt = AddOutPt(e, e.Top);
					}
					UpdateEdgeIntoAEL(ref e);
					TEdge prevInAEL3 = e.PrevInAEL;
					TEdge nextInAEL = e.NextInAEL;
					if (prevInAEL3 != null && prevInAEL3.Curr.X == e.Bot.X && prevInAEL3.Curr.Y == e.Bot.Y && outPt != null && prevInAEL3.OutIdx >= 0 && prevInAEL3.Curr.Y > prevInAEL3.Top.Y && ClipperBase.SlopesEqual(e.Curr, e.Top, prevInAEL3.Curr, prevInAEL3.Top, m_UseFullRange) && e.WindDelta != 0 && prevInAEL3.WindDelta != 0)
					{
						OutPt op3 = AddOutPt(prevInAEL3, e.Bot);
						AddJoin(outPt, op3, e.Top);
					}
					else if (nextInAEL != null && nextInAEL.Curr.X == e.Bot.X && nextInAEL.Curr.Y == e.Bot.Y && outPt != null && nextInAEL.OutIdx >= 0 && nextInAEL.Curr.Y > nextInAEL.Top.Y && ClipperBase.SlopesEqual(e.Curr, e.Top, nextInAEL.Curr, nextInAEL.Top, m_UseFullRange) && e.WindDelta != 0 && nextInAEL.WindDelta != 0)
					{
						OutPt op4 = AddOutPt(nextInAEL, e.Bot);
						AddJoin(outPt, op4, e.Top);
					}
				}
			}
		}

		private void DoMaxima(TEdge e)
		{
			TEdge maximaPairEx = GetMaximaPairEx(e);
			if (maximaPairEx == null)
			{
				if (e.OutIdx >= 0)
				{
					AddOutPt(e, e.Top);
				}
				DeleteFromAEL(e);
				return;
			}
			TEdge nextInAEL = e.NextInAEL;
			while (nextInAEL != null && nextInAEL != maximaPairEx)
			{
				IntersectEdges(e, nextInAEL, e.Top);
				SwapPositionsInAEL(e, nextInAEL);
				nextInAEL = e.NextInAEL;
			}
			if (e.OutIdx == -1 && maximaPairEx.OutIdx == -1)
			{
				DeleteFromAEL(e);
				DeleteFromAEL(maximaPairEx);
				return;
			}
			if (e.OutIdx >= 0 && maximaPairEx.OutIdx >= 0)
			{
				if (e.OutIdx >= 0)
				{
					AddLocalMaxPoly(e, maximaPairEx, e.Top);
				}
				DeleteFromAEL(e);
				DeleteFromAEL(maximaPairEx);
				return;
			}
			if (e.WindDelta == 0)
			{
				if (e.OutIdx >= 0)
				{
					AddOutPt(e, e.Top);
					e.OutIdx = -1;
				}
				DeleteFromAEL(e);
				if (maximaPairEx.OutIdx >= 0)
				{
					AddOutPt(maximaPairEx, e.Top);
					maximaPairEx.OutIdx = -1;
				}
				DeleteFromAEL(maximaPairEx);
				return;
			}
			throw new ClipperException("DoMaxima error");
		}

		public static void ReversePaths(List<List<IntPoint>> polys)
		{
			foreach (List<IntPoint> poly in polys)
			{
				poly.Reverse();
			}
		}

		public static bool Orientation(List<IntPoint> poly)
		{
			return Area(poly) >= 0.0;
		}

		private int PointCount(OutPt pts)
		{
			if (pts == null)
			{
				return 0;
			}
			int num = 0;
			OutPt outPt = pts;
			do
			{
				num++;
				outPt = outPt.Next;
			}
			while (outPt != pts);
			return num;
		}

		private void BuildResult(List<List<IntPoint>> polyg)
		{
			polyg.Clear();
			polyg.Capacity = m_PolyOuts.Count;
			for (int i = 0; i < m_PolyOuts.Count; i++)
			{
				OutRec outRec = m_PolyOuts[i];
				if (outRec.Pts == null)
				{
					continue;
				}
				OutPt prev = outRec.Pts.Prev;
				int num = PointCount(prev);
				if (num >= 2)
				{
					List<IntPoint> list = new List<IntPoint>(num);
					for (int j = 0; j < num; j++)
					{
						list.Add(prev.Pt);
						prev = prev.Prev;
					}
					polyg.Add(list);
				}
			}
		}

		private void BuildResult2(PolyTree polytree)
		{
			polytree.Clear();
			polytree.m_AllPolys.Capacity = m_PolyOuts.Count;
			for (int i = 0; i < m_PolyOuts.Count; i++)
			{
				OutRec outRec = m_PolyOuts[i];
				int num = PointCount(outRec.Pts);
				if ((!outRec.IsOpen || num >= 2) && (outRec.IsOpen || num >= 3))
				{
					FixHoleLinkage(outRec);
					PolyNode polyNode = new PolyNode();
					polytree.m_AllPolys.Add(polyNode);
					outRec.PolyNode = polyNode;
					polyNode.m_polygon.Capacity = num;
					OutPt prev = outRec.Pts.Prev;
					for (int j = 0; j < num; j++)
					{
						polyNode.m_polygon.Add(prev.Pt);
						prev = prev.Prev;
					}
				}
			}
			polytree.m_Childs.Capacity = m_PolyOuts.Count;
			for (int k = 0; k < m_PolyOuts.Count; k++)
			{
				OutRec outRec2 = m_PolyOuts[k];
				if (outRec2.PolyNode != null)
				{
					if (outRec2.IsOpen)
					{
						outRec2.PolyNode.IsOpen = true;
						polytree.AddChild(outRec2.PolyNode);
					}
					else if (outRec2.FirstLeft != null && outRec2.FirstLeft.PolyNode != null)
					{
						outRec2.FirstLeft.PolyNode.AddChild(outRec2.PolyNode);
					}
					else
					{
						polytree.AddChild(outRec2.PolyNode);
					}
				}
			}
		}

		private void FixupOutPolyline(OutRec outrec)
		{
			OutPt outPt = outrec.Pts;
			OutPt prev = outPt.Prev;
			while (outPt != prev)
			{
				outPt = outPt.Next;
				if (outPt.Pt == outPt.Prev.Pt)
				{
					if (outPt == prev)
					{
						prev = outPt.Prev;
					}
					OutPt prev2 = outPt.Prev;
					prev2.Next = outPt.Next;
					outPt.Next.Prev = prev2;
					outPt = prev2;
				}
			}
			if (outPt == outPt.Prev)
			{
				outrec.Pts = null;
			}
		}

		private void FixupOutPolygon(OutRec outRec)
		{
			OutPt outPt = null;
			outRec.BottomPt = null;
			OutPt outPt2 = outRec.Pts;
			bool flag = base.PreserveCollinear || StrictlySimple;
			while (true)
			{
				if (outPt2.Prev == outPt2 || outPt2.Prev == outPt2.Next)
				{
					outRec.Pts = null;
					return;
				}
				if (outPt2.Pt == outPt2.Next.Pt || outPt2.Pt == outPt2.Prev.Pt || (ClipperBase.SlopesEqual(outPt2.Prev.Pt, outPt2.Pt, outPt2.Next.Pt, m_UseFullRange) && (!flag || !Pt2IsBetweenPt1AndPt3(outPt2.Prev.Pt, outPt2.Pt, outPt2.Next.Pt))))
				{
					outPt = null;
					outPt2.Prev.Next = outPt2.Next;
					outPt2.Next.Prev = outPt2.Prev;
					outPt2 = outPt2.Prev;
					continue;
				}
				if (outPt2 == outPt)
				{
					break;
				}
				if (outPt == null)
				{
					outPt = outPt2;
				}
				outPt2 = outPt2.Next;
			}
			outRec.Pts = outPt2;
		}

		private OutPt DupOutPt(OutPt outPt, bool InsertAfter)
		{
			OutPt outPt2 = new OutPt();
			outPt2.Pt = outPt.Pt;
			outPt2.Idx = outPt.Idx;
			if (InsertAfter)
			{
				outPt2.Next = outPt.Next;
				outPt2.Prev = outPt;
				outPt.Next.Prev = outPt2;
				outPt.Next = outPt2;
			}
			else
			{
				outPt2.Prev = outPt.Prev;
				outPt2.Next = outPt;
				outPt.Prev.Next = outPt2;
				outPt.Prev = outPt2;
			}
			return outPt2;
		}

		private bool GetOverlap(long a1, long a2, long b1, long b2, out long Left, out long Right)
		{
			if (a1 < a2)
			{
				if (b1 < b2)
				{
					Left = Math.Max(a1, b1);
					Right = Math.Min(a2, b2);
				}
				else
				{
					Left = Math.Max(a1, b2);
					Right = Math.Min(a2, b1);
				}
			}
			else if (b1 < b2)
			{
				Left = Math.Max(a2, b1);
				Right = Math.Min(a1, b2);
			}
			else
			{
				Left = Math.Max(a2, b2);
				Right = Math.Min(a1, b1);
			}
			return Left < Right;
		}

		private bool JoinHorz(OutPt op1, OutPt op1b, OutPt op2, OutPt op2b, IntPoint Pt, bool DiscardLeft)
		{
			Direction direction = ((op1.Pt.X <= op1b.Pt.X) ? Direction.dLeftToRight : Direction.dRightToLeft);
			Direction direction2 = ((op2.Pt.X <= op2b.Pt.X) ? Direction.dLeftToRight : Direction.dRightToLeft);
			if (direction == direction2)
			{
				return false;
			}
			if (direction == Direction.dLeftToRight)
			{
				while (op1.Next.Pt.X <= Pt.X && op1.Next.Pt.X >= op1.Pt.X && op1.Next.Pt.Y == Pt.Y)
				{
					op1 = op1.Next;
				}
				if (DiscardLeft && op1.Pt.X != Pt.X)
				{
					op1 = op1.Next;
				}
				op1b = DupOutPt(op1, !DiscardLeft);
				if (op1b.Pt != Pt)
				{
					op1 = op1b;
					op1.Pt = Pt;
					op1b = DupOutPt(op1, !DiscardLeft);
				}
			}
			else
			{
				while (op1.Next.Pt.X >= Pt.X && op1.Next.Pt.X <= op1.Pt.X && op1.Next.Pt.Y == Pt.Y)
				{
					op1 = op1.Next;
				}
				if (!DiscardLeft && op1.Pt.X != Pt.X)
				{
					op1 = op1.Next;
				}
				op1b = DupOutPt(op1, DiscardLeft);
				if (op1b.Pt != Pt)
				{
					op1 = op1b;
					op1.Pt = Pt;
					op1b = DupOutPt(op1, DiscardLeft);
				}
			}
			if (direction2 == Direction.dLeftToRight)
			{
				while (op2.Next.Pt.X <= Pt.X && op2.Next.Pt.X >= op2.Pt.X && op2.Next.Pt.Y == Pt.Y)
				{
					op2 = op2.Next;
				}
				if (DiscardLeft && op2.Pt.X != Pt.X)
				{
					op2 = op2.Next;
				}
				op2b = DupOutPt(op2, !DiscardLeft);
				if (op2b.Pt != Pt)
				{
					op2 = op2b;
					op2.Pt = Pt;
					op2b = DupOutPt(op2, !DiscardLeft);
				}
			}
			else
			{
				while (op2.Next.Pt.X >= Pt.X && op2.Next.Pt.X <= op2.Pt.X && op2.Next.Pt.Y == Pt.Y)
				{
					op2 = op2.Next;
				}
				if (!DiscardLeft && op2.Pt.X != Pt.X)
				{
					op2 = op2.Next;
				}
				op2b = DupOutPt(op2, DiscardLeft);
				if (op2b.Pt != Pt)
				{
					op2 = op2b;
					op2.Pt = Pt;
					op2b = DupOutPt(op2, DiscardLeft);
				}
			}
			if (direction == Direction.dLeftToRight == DiscardLeft)
			{
				op1.Prev = op2;
				op2.Next = op1;
				op1b.Next = op2b;
				op2b.Prev = op1b;
			}
			else
			{
				op1.Next = op2;
				op2.Prev = op1;
				op1b.Prev = op2b;
				op2b.Next = op1b;
			}
			return true;
		}

		private bool JoinPoints(Join j, OutRec outRec1, OutRec outRec2)
		{
			OutPt outPt = j.OutPt1;
			OutPt outPt2 = j.OutPt2;
			bool flag = j.OutPt1.Pt.Y == j.OffPt.Y;
			OutPt next;
			OutPt next2;
			if (flag && j.OffPt == j.OutPt1.Pt && j.OffPt == j.OutPt2.Pt)
			{
				if (outRec1 != outRec2)
				{
					return false;
				}
				next = j.OutPt1.Next;
				while (next != outPt && next.Pt == j.OffPt)
				{
					next = next.Next;
				}
				bool flag2 = next.Pt.Y > j.OffPt.Y;
				next2 = j.OutPt2.Next;
				while (next2 != outPt2 && next2.Pt == j.OffPt)
				{
					next2 = next2.Next;
				}
				bool flag3 = next2.Pt.Y > j.OffPt.Y;
				if (flag2 == flag3)
				{
					return false;
				}
				if (flag2)
				{
					next = DupOutPt(outPt, InsertAfter: false);
					next2 = DupOutPt(outPt2, InsertAfter: true);
					outPt.Prev = outPt2;
					outPt2.Next = outPt;
					next.Next = next2;
					next2.Prev = next;
					j.OutPt1 = outPt;
					j.OutPt2 = next;
					return true;
				}
				next = DupOutPt(outPt, InsertAfter: true);
				next2 = DupOutPt(outPt2, InsertAfter: false);
				outPt.Next = outPt2;
				outPt2.Prev = outPt;
				next.Prev = next2;
				next2.Next = next;
				j.OutPt1 = outPt;
				j.OutPt2 = next;
				return true;
			}
			if (flag)
			{
				next = outPt;
				while (outPt.Prev.Pt.Y == outPt.Pt.Y && outPt.Prev != next && outPt.Prev != outPt2)
				{
					outPt = outPt.Prev;
				}
				while (next.Next.Pt.Y == next.Pt.Y && next.Next != outPt && next.Next != outPt2)
				{
					next = next.Next;
				}
				if (next.Next == outPt || next.Next == outPt2)
				{
					return false;
				}
				next2 = outPt2;
				while (outPt2.Prev.Pt.Y == outPt2.Pt.Y && outPt2.Prev != next2 && outPt2.Prev != next)
				{
					outPt2 = outPt2.Prev;
				}
				while (next2.Next.Pt.Y == next2.Pt.Y && next2.Next != outPt2 && next2.Next != outPt)
				{
					next2 = next2.Next;
				}
				if (next2.Next == outPt2 || next2.Next == outPt)
				{
					return false;
				}
				if (!GetOverlap(outPt.Pt.X, next.Pt.X, outPt2.Pt.X, next2.Pt.X, out var Left, out var Right))
				{
					return false;
				}
				IntPoint pt;
				bool discardLeft;
				if (outPt.Pt.X >= Left && outPt.Pt.X <= Right)
				{
					pt = outPt.Pt;
					discardLeft = outPt.Pt.X > next.Pt.X;
				}
				else if (outPt2.Pt.X >= Left && outPt2.Pt.X <= Right)
				{
					pt = outPt2.Pt;
					discardLeft = outPt2.Pt.X > next2.Pt.X;
				}
				else if (next.Pt.X >= Left && next.Pt.X <= Right)
				{
					pt = next.Pt;
					discardLeft = next.Pt.X > outPt.Pt.X;
				}
				else
				{
					pt = next2.Pt;
					discardLeft = next2.Pt.X > outPt2.Pt.X;
				}
				j.OutPt1 = outPt;
				j.OutPt2 = outPt2;
				return JoinHorz(outPt, next, outPt2, next2, pt, discardLeft);
			}
			next = outPt.Next;
			while (next.Pt == outPt.Pt && next != outPt)
			{
				next = next.Next;
			}
			bool flag4 = next.Pt.Y > outPt.Pt.Y || !ClipperBase.SlopesEqual(outPt.Pt, next.Pt, j.OffPt, m_UseFullRange);
			if (flag4)
			{
				next = outPt.Prev;
				while (next.Pt == outPt.Pt && next != outPt)
				{
					next = next.Prev;
				}
				if (next.Pt.Y > outPt.Pt.Y || !ClipperBase.SlopesEqual(outPt.Pt, next.Pt, j.OffPt, m_UseFullRange))
				{
					return false;
				}
			}
			next2 = outPt2.Next;
			while (next2.Pt == outPt2.Pt && next2 != outPt2)
			{
				next2 = next2.Next;
			}
			bool flag5 = next2.Pt.Y > outPt2.Pt.Y || !ClipperBase.SlopesEqual(outPt2.Pt, next2.Pt, j.OffPt, m_UseFullRange);
			if (flag5)
			{
				next2 = outPt2.Prev;
				while (next2.Pt == outPt2.Pt && next2 != outPt2)
				{
					next2 = next2.Prev;
				}
				if (next2.Pt.Y > outPt2.Pt.Y || !ClipperBase.SlopesEqual(outPt2.Pt, next2.Pt, j.OffPt, m_UseFullRange))
				{
					return false;
				}
			}
			if (next == outPt || next2 == outPt2 || next == next2 || (outRec1 == outRec2 && flag4 == flag5))
			{
				return false;
			}
			if (flag4)
			{
				next = DupOutPt(outPt, InsertAfter: false);
				next2 = DupOutPt(outPt2, InsertAfter: true);
				outPt.Prev = outPt2;
				outPt2.Next = outPt;
				next.Next = next2;
				next2.Prev = next;
				j.OutPt1 = outPt;
				j.OutPt2 = next;
				return true;
			}
			next = DupOutPt(outPt, InsertAfter: true);
			next2 = DupOutPt(outPt2, InsertAfter: false);
			outPt.Next = outPt2;
			outPt2.Prev = outPt;
			next.Prev = next2;
			next2.Next = next;
			j.OutPt1 = outPt;
			j.OutPt2 = next;
			return true;
		}

		public static int PointInPolygon(IntPoint pt, List<IntPoint> path)
		{
			int num = 0;
			int count = path.Count;
			if (count < 3)
			{
				return 0;
			}
			IntPoint intPoint = path[0];
			for (int i = 1; i <= count; i++)
			{
				IntPoint intPoint2 = ((i == count) ? path[0] : path[i]);
				if (intPoint2.Y == pt.Y && (intPoint2.X == pt.X || (intPoint.Y == pt.Y && intPoint2.X > pt.X == intPoint.X < pt.X)))
				{
					return -1;
				}
				if (intPoint.Y < pt.Y != intPoint2.Y < pt.Y)
				{
					if (intPoint.X >= pt.X)
					{
						if (intPoint2.X > pt.X)
						{
							num = 1 - num;
						}
						else
						{
							double num2 = (double)(intPoint.X - pt.X) * (double)(intPoint2.Y - pt.Y) - (double)(intPoint2.X - pt.X) * (double)(intPoint.Y - pt.Y);
							if (num2 == 0.0)
							{
								return -1;
							}
							if (num2 > 0.0 == intPoint2.Y > intPoint.Y)
							{
								num = 1 - num;
							}
						}
					}
					else if (intPoint2.X > pt.X)
					{
						double num3 = (double)(intPoint.X - pt.X) * (double)(intPoint2.Y - pt.Y) - (double)(intPoint2.X - pt.X) * (double)(intPoint.Y - pt.Y);
						if (num3 == 0.0)
						{
							return -1;
						}
						if (num3 > 0.0 == intPoint2.Y > intPoint.Y)
						{
							num = 1 - num;
						}
					}
				}
				intPoint = intPoint2;
			}
			return num;
		}

		private static int PointInPolygon(IntPoint pt, OutPt op)
		{
			int num = 0;
			OutPt outPt = op;
			long x = pt.X;
			long y = pt.Y;
			long num2 = op.Pt.X;
			long num3 = op.Pt.Y;
			do
			{
				op = op.Next;
				long x2 = op.Pt.X;
				long y2 = op.Pt.Y;
				if (y2 == y && (x2 == x || (num3 == y && x2 > x == num2 < x)))
				{
					return -1;
				}
				if (num3 < y != y2 < y)
				{
					if (num2 >= x)
					{
						if (x2 > x)
						{
							num = 1 - num;
						}
						else
						{
							double num4 = (double)(num2 - x) * (double)(y2 - y) - (double)(x2 - x) * (double)(num3 - y);
							if (num4 == 0.0)
							{
								return -1;
							}
							if (num4 > 0.0 == y2 > num3)
							{
								num = 1 - num;
							}
						}
					}
					else if (x2 > x)
					{
						double num5 = (double)(num2 - x) * (double)(y2 - y) - (double)(x2 - x) * (double)(num3 - y);
						if (num5 == 0.0)
						{
							return -1;
						}
						if (num5 > 0.0 == y2 > num3)
						{
							num = 1 - num;
						}
					}
				}
				num2 = x2;
				num3 = y2;
			}
			while (outPt != op);
			return num;
		}

		private static bool Poly2ContainsPoly1(OutPt outPt1, OutPt outPt2)
		{
			OutPt outPt3 = outPt1;
			do
			{
				int num = PointInPolygon(outPt3.Pt, outPt2);
				if (num >= 0)
				{
					return num > 0;
				}
				outPt3 = outPt3.Next;
			}
			while (outPt3 != outPt1);
			return true;
		}

		private void FixupFirstLefts1(OutRec OldOutRec, OutRec NewOutRec)
		{
			foreach (OutRec polyOut in m_PolyOuts)
			{
				OutRec outRec = ParseFirstLeft(polyOut.FirstLeft);
				if (polyOut.Pts != null && outRec == OldOutRec && Poly2ContainsPoly1(polyOut.Pts, NewOutRec.Pts))
				{
					polyOut.FirstLeft = NewOutRec;
				}
			}
		}

		private void FixupFirstLefts2(OutRec innerOutRec, OutRec outerOutRec)
		{
			OutRec firstLeft = outerOutRec.FirstLeft;
			foreach (OutRec polyOut in m_PolyOuts)
			{
				if (polyOut.Pts == null || polyOut == outerOutRec || polyOut == innerOutRec)
				{
					continue;
				}
				OutRec outRec = ParseFirstLeft(polyOut.FirstLeft);
				if (outRec == firstLeft || outRec == innerOutRec || outRec == outerOutRec)
				{
					if (Poly2ContainsPoly1(polyOut.Pts, innerOutRec.Pts))
					{
						polyOut.FirstLeft = innerOutRec;
					}
					else if (Poly2ContainsPoly1(polyOut.Pts, outerOutRec.Pts))
					{
						polyOut.FirstLeft = outerOutRec;
					}
					else if (polyOut.FirstLeft == innerOutRec || polyOut.FirstLeft == outerOutRec)
					{
						polyOut.FirstLeft = firstLeft;
					}
				}
			}
		}

		private void FixupFirstLefts3(OutRec OldOutRec, OutRec NewOutRec)
		{
			foreach (OutRec polyOut in m_PolyOuts)
			{
				OutRec outRec = ParseFirstLeft(polyOut.FirstLeft);
				if (polyOut.Pts != null && outRec == OldOutRec)
				{
					polyOut.FirstLeft = NewOutRec;
				}
			}
		}

		private static OutRec ParseFirstLeft(OutRec FirstLeft)
		{
			while (FirstLeft != null && FirstLeft.Pts == null)
			{
				FirstLeft = FirstLeft.FirstLeft;
			}
			return FirstLeft;
		}

		private void JoinCommonEdges()
		{
			for (int i = 0; i < m_Joins.Count; i++)
			{
				Join obj = m_Joins[i];
				OutRec outRec = GetOutRec(obj.OutPt1.Idx);
				OutRec outRec2 = GetOutRec(obj.OutPt2.Idx);
				if (outRec.Pts == null || outRec2.Pts == null || outRec.IsOpen || outRec2.IsOpen)
				{
					continue;
				}
				OutRec outRec3 = ((outRec == outRec2) ? outRec : (OutRec1RightOfOutRec2(outRec, outRec2) ? outRec2 : ((!OutRec1RightOfOutRec2(outRec2, outRec)) ? GetLowermostRec(outRec, outRec2) : outRec)));
				if (!JoinPoints(obj, outRec, outRec2))
				{
					continue;
				}
				if (outRec == outRec2)
				{
					outRec.Pts = obj.OutPt1;
					outRec.BottomPt = null;
					outRec2 = CreateOutRec();
					outRec2.Pts = obj.OutPt2;
					UpdateOutPtIdxs(outRec2);
					if (Poly2ContainsPoly1(outRec2.Pts, outRec.Pts))
					{
						outRec2.IsHole = !outRec.IsHole;
						outRec2.FirstLeft = outRec;
						if (m_UsingPolyTree)
						{
							FixupFirstLefts2(outRec2, outRec);
						}
						if ((outRec2.IsHole ^ ReverseSolution) == Area(outRec2) > 0.0)
						{
							ReversePolyPtLinks(outRec2.Pts);
						}
					}
					else if (Poly2ContainsPoly1(outRec.Pts, outRec2.Pts))
					{
						outRec2.IsHole = outRec.IsHole;
						outRec.IsHole = !outRec2.IsHole;
						outRec2.FirstLeft = outRec.FirstLeft;
						outRec.FirstLeft = outRec2;
						if (m_UsingPolyTree)
						{
							FixupFirstLefts2(outRec, outRec2);
						}
						if ((outRec.IsHole ^ ReverseSolution) == Area(outRec) > 0.0)
						{
							ReversePolyPtLinks(outRec.Pts);
						}
					}
					else
					{
						outRec2.IsHole = outRec.IsHole;
						outRec2.FirstLeft = outRec.FirstLeft;
						if (m_UsingPolyTree)
						{
							FixupFirstLefts1(outRec, outRec2);
						}
					}
				}
				else
				{
					outRec2.Pts = null;
					outRec2.BottomPt = null;
					outRec2.Idx = outRec.Idx;
					outRec.IsHole = outRec3.IsHole;
					if (outRec3 == outRec2)
					{
						outRec.FirstLeft = outRec2.FirstLeft;
					}
					outRec2.FirstLeft = outRec;
					if (m_UsingPolyTree)
					{
						FixupFirstLefts3(outRec2, outRec);
					}
				}
			}
		}

		private void UpdateOutPtIdxs(OutRec outrec)
		{
			OutPt outPt = outrec.Pts;
			do
			{
				outPt.Idx = outrec.Idx;
				outPt = outPt.Prev;
			}
			while (outPt != outrec.Pts);
		}

		private void DoSimplePolygons()
		{
			int num = 0;
			while (num < m_PolyOuts.Count)
			{
				OutRec outRec = m_PolyOuts[num++];
				OutPt outPt = outRec.Pts;
				if (outPt == null || outRec.IsOpen)
				{
					continue;
				}
				do
				{
					for (OutPt outPt2 = outPt.Next; outPt2 != outRec.Pts; outPt2 = outPt2.Next)
					{
						if (outPt.Pt == outPt2.Pt && outPt2.Next != outPt && outPt2.Prev != outPt)
						{
							OutPt prev = outPt.Prev;
							(outPt.Prev = outPt2.Prev).Next = outPt;
							outPt2.Prev = prev;
							prev.Next = outPt2;
							outRec.Pts = outPt;
							OutRec outRec2 = CreateOutRec();
							outRec2.Pts = outPt2;
							UpdateOutPtIdxs(outRec2);
							if (Poly2ContainsPoly1(outRec2.Pts, outRec.Pts))
							{
								outRec2.IsHole = !outRec.IsHole;
								outRec2.FirstLeft = outRec;
								if (m_UsingPolyTree)
								{
									FixupFirstLefts2(outRec2, outRec);
								}
							}
							else if (Poly2ContainsPoly1(outRec.Pts, outRec2.Pts))
							{
								outRec2.IsHole = outRec.IsHole;
								outRec.IsHole = !outRec2.IsHole;
								outRec2.FirstLeft = outRec.FirstLeft;
								outRec.FirstLeft = outRec2;
								if (m_UsingPolyTree)
								{
									FixupFirstLefts2(outRec, outRec2);
								}
							}
							else
							{
								outRec2.IsHole = outRec.IsHole;
								outRec2.FirstLeft = outRec.FirstLeft;
								if (m_UsingPolyTree)
								{
									FixupFirstLefts1(outRec, outRec2);
								}
							}
							outPt2 = outPt;
						}
					}
					outPt = outPt.Next;
				}
				while (outPt != outRec.Pts);
			}
		}

		public static double Area(List<IntPoint> poly)
		{
			int count = poly.Count;
			if (count < 3)
			{
				return 0.0;
			}
			double num = 0.0;
			int i = 0;
			int index = count - 1;
			for (; i < count; i++)
			{
				num += ((double)poly[index].X + (double)poly[i].X) * ((double)poly[index].Y - (double)poly[i].Y);
				index = i;
			}
			return (0.0 - num) * 0.5;
		}

		internal double Area(OutRec outRec)
		{
			return Area(outRec.Pts);
		}

		internal double Area(OutPt op)
		{
			OutPt outPt = op;
			if (op == null)
			{
				return 0.0;
			}
			double num = 0.0;
			do
			{
				num += (double)(op.Prev.Pt.X + op.Pt.X) * (double)(op.Prev.Pt.Y - op.Pt.Y);
				op = op.Next;
			}
			while (op != outPt);
			return num * 0.5;
		}

		public static List<List<IntPoint>> SimplifyPolygon(List<IntPoint> poly, PolyFillType fillType = PolyFillType.pftEvenOdd)
		{
			List<List<IntPoint>> list = new List<List<IntPoint>>();
			Clipper clipper = new Clipper();
			clipper.StrictlySimple = true;
			clipper.AddPath(poly, PolyType.ptSubject, Closed: true);
			clipper.Execute(ClipType.ctUnion, list, fillType, fillType);
			return list;
		}

		public static List<List<IntPoint>> SimplifyPolygons(List<List<IntPoint>> polys, PolyFillType fillType = PolyFillType.pftEvenOdd)
		{
			List<List<IntPoint>> list = new List<List<IntPoint>>();
			Clipper clipper = new Clipper();
			clipper.StrictlySimple = true;
			clipper.AddPaths(polys, PolyType.ptSubject, closed: true);
			clipper.Execute(ClipType.ctUnion, list, fillType, fillType);
			return list;
		}

		private static double DistanceSqrd(IntPoint pt1, IntPoint pt2)
		{
			double num = (double)pt1.X - (double)pt2.X;
			double num2 = (double)pt1.Y - (double)pt2.Y;
			return num * num + num2 * num2;
		}

		private static double DistanceFromLineSqrd(IntPoint pt, IntPoint ln1, IntPoint ln2)
		{
			double num = ln1.Y - ln2.Y;
			double num2 = ln2.X - ln1.X;
			double num3 = num * (double)ln1.X + num2 * (double)ln1.Y;
			num3 = num * (double)pt.X + num2 * (double)pt.Y - num3;
			return num3 * num3 / (num * num + num2 * num2);
		}

		private static bool SlopesNearCollinear(IntPoint pt1, IntPoint pt2, IntPoint pt3, double distSqrd)
		{
			if (Math.Abs(pt1.X - pt2.X) > Math.Abs(pt1.Y - pt2.Y))
			{
				if (pt1.X > pt2.X == pt1.X < pt3.X)
				{
					return DistanceFromLineSqrd(pt1, pt2, pt3) < distSqrd;
				}
				if (pt2.X > pt1.X == pt2.X < pt3.X)
				{
					return DistanceFromLineSqrd(pt2, pt1, pt3) < distSqrd;
				}
				return DistanceFromLineSqrd(pt3, pt1, pt2) < distSqrd;
			}
			if (pt1.Y > pt2.Y == pt1.Y < pt3.Y)
			{
				return DistanceFromLineSqrd(pt1, pt2, pt3) < distSqrd;
			}
			if (pt2.Y > pt1.Y == pt2.Y < pt3.Y)
			{
				return DistanceFromLineSqrd(pt2, pt1, pt3) < distSqrd;
			}
			return DistanceFromLineSqrd(pt3, pt1, pt2) < distSqrd;
		}

		private static bool PointsAreClose(IntPoint pt1, IntPoint pt2, double distSqrd)
		{
			double num = (double)pt1.X - (double)pt2.X;
			double num2 = (double)pt1.Y - (double)pt2.Y;
			return num * num + num2 * num2 <= distSqrd;
		}

		private static OutPt ExcludeOp(OutPt op)
		{
			OutPt prev = op.Prev;
			prev.Next = op.Next;
			op.Next.Prev = prev;
			prev.Idx = 0;
			return prev;
		}

		public static List<IntPoint> CleanPolygon(List<IntPoint> path, double distance = 1.415)
		{
			int num = path.Count;
			if (num == 0)
			{
				return new List<IntPoint>();
			}
			OutPt[] array = new OutPt[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = new OutPt();
			}
			for (int j = 0; j < num; j++)
			{
				array[j].Pt = path[j];
				array[j].Next = array[(j + 1) % num];
				array[j].Next.Prev = array[j];
				array[j].Idx = 0;
			}
			double distSqrd = distance * distance;
			OutPt outPt = array[0];
			while (outPt.Idx == 0 && outPt.Next != outPt.Prev)
			{
				if (PointsAreClose(outPt.Pt, outPt.Prev.Pt, distSqrd))
				{
					outPt = ExcludeOp(outPt);
					num--;
				}
				else if (PointsAreClose(outPt.Prev.Pt, outPt.Next.Pt, distSqrd))
				{
					ExcludeOp(outPt.Next);
					outPt = ExcludeOp(outPt);
					num -= 2;
				}
				else if (SlopesNearCollinear(outPt.Prev.Pt, outPt.Pt, outPt.Next.Pt, distSqrd))
				{
					outPt = ExcludeOp(outPt);
					num--;
				}
				else
				{
					outPt.Idx = 1;
					outPt = outPt.Next;
				}
			}
			if (num < 3)
			{
				num = 0;
			}
			List<IntPoint> list = new List<IntPoint>(num);
			for (int k = 0; k < num; k++)
			{
				list.Add(outPt.Pt);
				outPt = outPt.Next;
			}
			array = null;
			return list;
		}

		public static List<List<IntPoint>> CleanPolygons(List<List<IntPoint>> polys, double distance = 1.415)
		{
			List<List<IntPoint>> list = new List<List<IntPoint>>(polys.Count);
			for (int i = 0; i < polys.Count; i++)
			{
				list.Add(CleanPolygon(polys[i], distance));
			}
			return list;
		}

		internal static List<List<IntPoint>> Minkowski(List<IntPoint> pattern, List<IntPoint> path, bool IsSum, bool IsClosed)
		{
			int num = (IsClosed ? 1 : 0);
			int count = pattern.Count;
			int count2 = path.Count;
			List<List<IntPoint>> list = new List<List<IntPoint>>(count2);
			if (IsSum)
			{
				for (int i = 0; i < count2; i++)
				{
					List<IntPoint> list2 = new List<IntPoint>(count);
					foreach (IntPoint item in pattern)
					{
						list2.Add(new IntPoint(path[i].X + item.X, path[i].Y + item.Y));
					}
					list.Add(list2);
				}
			}
			else
			{
				for (int j = 0; j < count2; j++)
				{
					List<IntPoint> list3 = new List<IntPoint>(count);
					foreach (IntPoint item2 in pattern)
					{
						list3.Add(new IntPoint(path[j].X - item2.X, path[j].Y - item2.Y));
					}
					list.Add(list3);
				}
			}
			List<List<IntPoint>> list4 = new List<List<IntPoint>>((count2 + num) * (count + 1));
			for (int k = 0; k < count2 - 1 + num; k++)
			{
				for (int l = 0; l < count; l++)
				{
					List<IntPoint> list5 = new List<IntPoint>(4);
					list5.Add(list[k % count2][l % count]);
					list5.Add(list[(k + 1) % count2][l % count]);
					list5.Add(list[(k + 1) % count2][(l + 1) % count]);
					list5.Add(list[k % count2][(l + 1) % count]);
					if (!Orientation(list5))
					{
						list5.Reverse();
					}
					list4.Add(list5);
				}
			}
			return list4;
		}

		public static List<List<IntPoint>> MinkowskiSum(List<IntPoint> pattern, List<IntPoint> path, bool pathIsClosed)
		{
			List<List<IntPoint>> list = Minkowski(pattern, path, IsSum: true, pathIsClosed);
			Clipper clipper = new Clipper();
			clipper.AddPaths(list, PolyType.ptSubject, closed: true);
			clipper.Execute(ClipType.ctUnion, list, PolyFillType.pftNonZero, PolyFillType.pftNonZero);
			return list;
		}

		private static List<IntPoint> TranslatePath(List<IntPoint> path, IntPoint delta)
		{
			List<IntPoint> list = new List<IntPoint>(path.Count);
			for (int i = 0; i < path.Count; i++)
			{
				list.Add(new IntPoint(path[i].X + delta.X, path[i].Y + delta.Y));
			}
			return list;
		}

		public static List<List<IntPoint>> MinkowskiSum(List<IntPoint> pattern, List<List<IntPoint>> paths, bool pathIsClosed)
		{
			List<List<IntPoint>> list = new List<List<IntPoint>>();
			Clipper clipper = new Clipper();
			for (int i = 0; i < paths.Count; i++)
			{
				List<List<IntPoint>> ppg = Minkowski(pattern, paths[i], IsSum: true, pathIsClosed);
				clipper.AddPaths(ppg, PolyType.ptSubject, closed: true);
				if (pathIsClosed)
				{
					List<IntPoint> pg = TranslatePath(paths[i], pattern[0]);
					clipper.AddPath(pg, PolyType.ptClip, Closed: true);
				}
			}
			clipper.Execute(ClipType.ctUnion, list, PolyFillType.pftNonZero, PolyFillType.pftNonZero);
			return list;
		}

		public static List<List<IntPoint>> MinkowskiDiff(List<IntPoint> poly1, List<IntPoint> poly2)
		{
			List<List<IntPoint>> list = Minkowski(poly1, poly2, IsSum: false, IsClosed: true);
			Clipper clipper = new Clipper();
			clipper.AddPaths(list, PolyType.ptSubject, closed: true);
			clipper.Execute(ClipType.ctUnion, list, PolyFillType.pftNonZero, PolyFillType.pftNonZero);
			return list;
		}

		public static List<List<IntPoint>> PolyTreeToPaths(PolyTree polytree)
		{
			List<List<IntPoint>> list = new List<List<IntPoint>>();
			list.Capacity = polytree.Total;
			AddPolyNodeToPaths(polytree, NodeType.ntAny, list);
			return list;
		}

		internal static void AddPolyNodeToPaths(PolyNode polynode, NodeType nt, List<List<IntPoint>> paths)
		{
			bool flag = true;
			switch (nt)
			{
			case NodeType.ntOpen:
				return;
			case NodeType.ntClosed:
				flag = !polynode.IsOpen;
				break;
			}
			if ((polynode.m_polygon.Count > 0) & flag)
			{
				paths.Add(polynode.m_polygon);
			}
			foreach (PolyNode child in polynode.Childs)
			{
				AddPolyNodeToPaths(child, nt, paths);
			}
		}

		public static List<List<IntPoint>> OpenPathsFromPolyTree(PolyTree polytree)
		{
			List<List<IntPoint>> list = new List<List<IntPoint>>();
			list.Capacity = polytree.ChildCount;
			for (int i = 0; i < polytree.ChildCount; i++)
			{
				if (polytree.Childs[i].IsOpen)
				{
					list.Add(polytree.Childs[i].m_polygon);
				}
			}
			return list;
		}

		public static List<List<IntPoint>> ClosedPathsFromPolyTree(PolyTree polytree)
		{
			List<List<IntPoint>> list = new List<List<IntPoint>>();
			list.Capacity = polytree.Total;
			AddPolyNodeToPaths(polytree, NodeType.ntClosed, list);
			return list;
		}
	}

	public class ClipperOffset
	{
		private List<List<IntPoint>> m_destPolys;

		private List<IntPoint> m_srcPoly;

		private List<IntPoint> m_destPoly;

		private List<DoublePoint> m_normals = new List<DoublePoint>();

		private double m_delta;

		private double m_sinA;

		private double m_sin;

		private double m_cos;

		private double m_miterLim;

		private double m_StepsPerRad;

		private IntPoint m_lowest;

		private PolyNode m_polyNodes = new PolyNode();

		private const double two_pi = Math.PI * 2.0;

		private const double def_arc_tolerance = 0.25;

		public double ArcTolerance { get; set; }

		public double MiterLimit { get; set; }

		public ClipperOffset(double miterLimit = 2.0, double arcTolerance = 0.25)
		{
			MiterLimit = miterLimit;
			ArcTolerance = arcTolerance;
			m_lowest.X = -1L;
		}

		public void Clear()
		{
			m_polyNodes.Childs.Clear();
			m_lowest.X = -1L;
		}

		internal static long Round(double value)
		{
			if (!(value < 0.0))
			{
				return (long)(value + 0.5);
			}
			return (long)(value - 0.5);
		}

		public void AddPath(List<IntPoint> path, JoinType joinType, EndType endType)
		{
			int num = path.Count - 1;
			if (num < 0)
			{
				return;
			}
			PolyNode polyNode = new PolyNode();
			polyNode.m_jointype = joinType;
			polyNode.m_endtype = endType;
			if (endType == EndType.etClosedLine || endType == EndType.etClosedPolygon)
			{
				while (num > 0 && path[0] == path[num])
				{
					num--;
				}
			}
			polyNode.m_polygon.Capacity = num + 1;
			polyNode.m_polygon.Add(path[0]);
			int num2 = 0;
			int num3 = 0;
			for (int i = 1; i <= num; i++)
			{
				if (polyNode.m_polygon[num2] != path[i])
				{
					num2++;
					polyNode.m_polygon.Add(path[i]);
					if (path[i].Y > polyNode.m_polygon[num3].Y || (path[i].Y == polyNode.m_polygon[num3].Y && path[i].X < polyNode.m_polygon[num3].X))
					{
						num3 = num2;
					}
				}
			}
			if (endType == EndType.etClosedPolygon && num2 < 2)
			{
				return;
			}
			m_polyNodes.AddChild(polyNode);
			if (endType != EndType.etClosedPolygon)
			{
				return;
			}
			if (m_lowest.X < 0)
			{
				m_lowest = new IntPoint(m_polyNodes.ChildCount - 1, num3);
				return;
			}
			IntPoint intPoint = m_polyNodes.Childs[(int)m_lowest.X].m_polygon[(int)m_lowest.Y];
			if (polyNode.m_polygon[num3].Y > intPoint.Y || (polyNode.m_polygon[num3].Y == intPoint.Y && polyNode.m_polygon[num3].X < intPoint.X))
			{
				m_lowest = new IntPoint(m_polyNodes.ChildCount - 1, num3);
			}
		}

		public void AddPaths(List<List<IntPoint>> paths, JoinType joinType, EndType endType)
		{
			foreach (List<IntPoint> path in paths)
			{
				AddPath(path, joinType, endType);
			}
		}

		private void FixOrientations()
		{
			if (m_lowest.X >= 0 && !Clipper.Orientation(m_polyNodes.Childs[(int)m_lowest.X].m_polygon))
			{
				for (int i = 0; i < m_polyNodes.ChildCount; i++)
				{
					PolyNode polyNode = m_polyNodes.Childs[i];
					if (polyNode.m_endtype == EndType.etClosedPolygon || (polyNode.m_endtype == EndType.etClosedLine && Clipper.Orientation(polyNode.m_polygon)))
					{
						polyNode.m_polygon.Reverse();
					}
				}
				return;
			}
			for (int j = 0; j < m_polyNodes.ChildCount; j++)
			{
				PolyNode polyNode2 = m_polyNodes.Childs[j];
				if (polyNode2.m_endtype == EndType.etClosedLine && !Clipper.Orientation(polyNode2.m_polygon))
				{
					polyNode2.m_polygon.Reverse();
				}
			}
		}

		internal static DoublePoint GetUnitNormal(IntPoint pt1, IntPoint pt2)
		{
			double num = pt2.X - pt1.X;
			double num2 = pt2.Y - pt1.Y;
			if (num == 0.0 && num2 == 0.0)
			{
				return default(DoublePoint);
			}
			double num3 = 1.0 / Math.Sqrt(num * num + num2 * num2);
			num *= num3;
			num2 *= num3;
			return new DoublePoint(num2, 0.0 - num);
		}

		private void DoOffset(double delta)
		{
			m_destPolys = new List<List<IntPoint>>();
			m_delta = delta;
			if (ClipperBase.near_zero(delta))
			{
				m_destPolys.Capacity = m_polyNodes.ChildCount;
				for (int i = 0; i < m_polyNodes.ChildCount; i++)
				{
					PolyNode polyNode = m_polyNodes.Childs[i];
					if (polyNode.m_endtype == EndType.etClosedPolygon)
					{
						m_destPolys.Add(polyNode.m_polygon);
					}
				}
				return;
			}
			if (MiterLimit > 2.0)
			{
				m_miterLim = 2.0 / (MiterLimit * MiterLimit);
			}
			else
			{
				m_miterLim = 0.5;
			}
			double num = ((ArcTolerance <= 0.0) ? 0.25 : ((!(ArcTolerance > Math.Abs(delta) * 0.25)) ? ArcTolerance : (Math.Abs(delta) * 0.25)));
			double num2 = Math.PI / Math.Acos(1.0 - num / Math.Abs(delta));
			m_sin = Math.Sin(Math.PI * 2.0 / num2);
			m_cos = Math.Cos(Math.PI * 2.0 / num2);
			m_StepsPerRad = num2 / (Math.PI * 2.0);
			if (delta < 0.0)
			{
				m_sin = 0.0 - m_sin;
			}
			m_destPolys.Capacity = m_polyNodes.ChildCount * 2;
			for (int j = 0; j < m_polyNodes.ChildCount; j++)
			{
				PolyNode polyNode2 = m_polyNodes.Childs[j];
				m_srcPoly = polyNode2.m_polygon;
				int count = m_srcPoly.Count;
				if (count == 0 || (delta <= 0.0 && (count < 3 || polyNode2.m_endtype != EndType.etClosedPolygon)))
				{
					continue;
				}
				m_destPoly = new List<IntPoint>();
				if (count == 1)
				{
					if (polyNode2.m_jointype == JoinType.jtRound)
					{
						double num3 = 1.0;
						double num4 = 0.0;
						for (int k = 1; (double)k <= num2; k++)
						{
							m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[0].X + num3 * delta), Round((double)m_srcPoly[0].Y + num4 * delta)));
							double num5 = num3;
							num3 = num3 * m_cos - m_sin * num4;
							num4 = num5 * m_sin + num4 * m_cos;
						}
					}
					else
					{
						double num6 = -1.0;
						double num7 = -1.0;
						for (int l = 0; l < 4; l++)
						{
							m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[0].X + num6 * delta), Round((double)m_srcPoly[0].Y + num7 * delta)));
							if (num6 < 0.0)
							{
								num6 = 1.0;
							}
							else if (num7 < 0.0)
							{
								num7 = 1.0;
							}
							else
							{
								num6 = -1.0;
							}
						}
					}
					m_destPolys.Add(m_destPoly);
					continue;
				}
				m_normals.Clear();
				m_normals.Capacity = count;
				for (int m = 0; m < count - 1; m++)
				{
					m_normals.Add(GetUnitNormal(m_srcPoly[m], m_srcPoly[m + 1]));
				}
				if (polyNode2.m_endtype == EndType.etClosedLine || polyNode2.m_endtype == EndType.etClosedPolygon)
				{
					m_normals.Add(GetUnitNormal(m_srcPoly[count - 1], m_srcPoly[0]));
				}
				else
				{
					m_normals.Add(new DoublePoint(m_normals[count - 2]));
				}
				if (polyNode2.m_endtype == EndType.etClosedPolygon)
				{
					int k2 = count - 1;
					for (int n = 0; n < count; n++)
					{
						OffsetPoint(n, ref k2, polyNode2.m_jointype);
					}
					m_destPolys.Add(m_destPoly);
					continue;
				}
				if (polyNode2.m_endtype == EndType.etClosedLine)
				{
					int k3 = count - 1;
					for (int num8 = 0; num8 < count; num8++)
					{
						OffsetPoint(num8, ref k3, polyNode2.m_jointype);
					}
					m_destPolys.Add(m_destPoly);
					m_destPoly = new List<IntPoint>();
					DoublePoint doublePoint = m_normals[count - 1];
					for (int num9 = count - 1; num9 > 0; num9--)
					{
						m_normals[num9] = new DoublePoint(0.0 - m_normals[num9 - 1].X, 0.0 - m_normals[num9 - 1].Y);
					}
					m_normals[0] = new DoublePoint(0.0 - doublePoint.X, 0.0 - doublePoint.Y);
					k3 = 0;
					for (int num10 = count - 1; num10 >= 0; num10--)
					{
						OffsetPoint(num10, ref k3, polyNode2.m_jointype);
					}
					m_destPolys.Add(m_destPoly);
					continue;
				}
				int k4 = 0;
				for (int num11 = 1; num11 < count - 1; num11++)
				{
					OffsetPoint(num11, ref k4, polyNode2.m_jointype);
				}
				if (polyNode2.m_endtype == EndType.etOpenButt)
				{
					int index = count - 1;
					IntPoint item = new IntPoint(Round((double)m_srcPoly[index].X + m_normals[index].X * delta), Round((double)m_srcPoly[index].Y + m_normals[index].Y * delta));
					m_destPoly.Add(item);
					item = new IntPoint(Round((double)m_srcPoly[index].X - m_normals[index].X * delta), Round((double)m_srcPoly[index].Y - m_normals[index].Y * delta));
					m_destPoly.Add(item);
				}
				else
				{
					int num12 = count - 1;
					k4 = count - 2;
					m_sinA = 0.0;
					m_normals[num12] = new DoublePoint(0.0 - m_normals[num12].X, 0.0 - m_normals[num12].Y);
					if (polyNode2.m_endtype == EndType.etOpenSquare)
					{
						DoSquare(num12, k4);
					}
					else
					{
						DoRound(num12, k4);
					}
				}
				for (int num13 = count - 1; num13 > 0; num13--)
				{
					m_normals[num13] = new DoublePoint(0.0 - m_normals[num13 - 1].X, 0.0 - m_normals[num13 - 1].Y);
				}
				m_normals[0] = new DoublePoint(0.0 - m_normals[1].X, 0.0 - m_normals[1].Y);
				k4 = count - 1;
				for (int num14 = k4 - 1; num14 > 0; num14--)
				{
					OffsetPoint(num14, ref k4, polyNode2.m_jointype);
				}
				if (polyNode2.m_endtype == EndType.etOpenButt)
				{
					IntPoint item = new IntPoint(Round((double)m_srcPoly[0].X - m_normals[0].X * delta), Round((double)m_srcPoly[0].Y - m_normals[0].Y * delta));
					m_destPoly.Add(item);
					item = new IntPoint(Round((double)m_srcPoly[0].X + m_normals[0].X * delta), Round((double)m_srcPoly[0].Y + m_normals[0].Y * delta));
					m_destPoly.Add(item);
				}
				else
				{
					k4 = 1;
					m_sinA = 0.0;
					if (polyNode2.m_endtype == EndType.etOpenSquare)
					{
						DoSquare(0, 1);
					}
					else
					{
						DoRound(0, 1);
					}
				}
				m_destPolys.Add(m_destPoly);
			}
		}

		public void Execute(ref List<List<IntPoint>> solution, double delta)
		{
			solution.Clear();
			FixOrientations();
			DoOffset(delta);
			Clipper clipper = new Clipper();
			clipper.AddPaths(m_destPolys, PolyType.ptSubject, closed: true);
			if (delta > 0.0)
			{
				clipper.Execute(ClipType.ctUnion, solution, PolyFillType.pftPositive, PolyFillType.pftPositive);
				return;
			}
			IntRect bounds = ClipperBase.GetBounds(m_destPolys);
			List<IntPoint> list = new List<IntPoint>(4);
			list.Add(new IntPoint(bounds.left - 10, bounds.bottom + 10));
			list.Add(new IntPoint(bounds.right + 10, bounds.bottom + 10));
			list.Add(new IntPoint(bounds.right + 10, bounds.top - 10));
			list.Add(new IntPoint(bounds.left - 10, bounds.top - 10));
			clipper.AddPath(list, PolyType.ptSubject, Closed: true);
			clipper.ReverseSolution = true;
			clipper.Execute(ClipType.ctUnion, solution, PolyFillType.pftNegative, PolyFillType.pftNegative);
			if (solution.Count > 0)
			{
				solution.RemoveAt(0);
			}
		}

		public void Execute(ref PolyTree solution, double delta)
		{
			solution.Clear();
			FixOrientations();
			DoOffset(delta);
			Clipper clipper = new Clipper();
			clipper.AddPaths(m_destPolys, PolyType.ptSubject, closed: true);
			if (delta > 0.0)
			{
				clipper.Execute(ClipType.ctUnion, solution, PolyFillType.pftPositive, PolyFillType.pftPositive);
				return;
			}
			IntRect bounds = ClipperBase.GetBounds(m_destPolys);
			List<IntPoint> list = new List<IntPoint>(4);
			list.Add(new IntPoint(bounds.left - 10, bounds.bottom + 10));
			list.Add(new IntPoint(bounds.right + 10, bounds.bottom + 10));
			list.Add(new IntPoint(bounds.right + 10, bounds.top - 10));
			list.Add(new IntPoint(bounds.left - 10, bounds.top - 10));
			clipper.AddPath(list, PolyType.ptSubject, Closed: true);
			clipper.ReverseSolution = true;
			clipper.Execute(ClipType.ctUnion, solution, PolyFillType.pftNegative, PolyFillType.pftNegative);
			if (solution.ChildCount == 1 && solution.Childs[0].ChildCount > 0)
			{
				PolyNode polyNode = solution.Childs[0];
				solution.Childs.Capacity = polyNode.ChildCount;
				solution.Childs[0] = polyNode.Childs[0];
				solution.Childs[0].m_Parent = solution;
				for (int i = 1; i < polyNode.ChildCount; i++)
				{
					solution.AddChild(polyNode.Childs[i]);
				}
			}
			else
			{
				solution.Clear();
			}
		}

		private void OffsetPoint(int j, ref int k, JoinType jointype)
		{
			m_sinA = m_normals[k].X * m_normals[j].Y - m_normals[j].X * m_normals[k].Y;
			if (Math.Abs(m_sinA * m_delta) < 1.0)
			{
				if (m_normals[k].X * m_normals[j].X + m_normals[j].Y * m_normals[k].Y > 0.0)
				{
					m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + m_normals[k].X * m_delta), Round((double)m_srcPoly[j].Y + m_normals[k].Y * m_delta)));
					return;
				}
			}
			else if (m_sinA > 1.0)
			{
				m_sinA = 1.0;
			}
			else if (m_sinA < -1.0)
			{
				m_sinA = -1.0;
			}
			if (m_sinA * m_delta < 0.0)
			{
				m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + m_normals[k].X * m_delta), Round((double)m_srcPoly[j].Y + m_normals[k].Y * m_delta)));
				m_destPoly.Add(m_srcPoly[j]);
				m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + m_normals[j].X * m_delta), Round((double)m_srcPoly[j].Y + m_normals[j].Y * m_delta)));
			}
			else
			{
				switch (jointype)
				{
				case JoinType.jtMiter:
				{
					double num = 1.0 + (m_normals[j].X * m_normals[k].X + m_normals[j].Y * m_normals[k].Y);
					if (num >= m_miterLim)
					{
						DoMiter(j, k, num);
					}
					else
					{
						DoSquare(j, k);
					}
					break;
				}
				case JoinType.jtSquare:
					DoSquare(j, k);
					break;
				case JoinType.jtRound:
					DoRound(j, k);
					break;
				}
			}
			k = j;
		}

		internal void DoSquare(int j, int k)
		{
			double num = Math.Tan(Math.Atan2(m_sinA, m_normals[k].X * m_normals[j].X + m_normals[k].Y * m_normals[j].Y) / 4.0);
			m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + m_delta * (m_normals[k].X - m_normals[k].Y * num)), Round((double)m_srcPoly[j].Y + m_delta * (m_normals[k].Y + m_normals[k].X * num))));
			m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + m_delta * (m_normals[j].X + m_normals[j].Y * num)), Round((double)m_srcPoly[j].Y + m_delta * (m_normals[j].Y - m_normals[j].X * num))));
		}

		internal void DoMiter(int j, int k, double r)
		{
			double num = m_delta / r;
			m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + (m_normals[k].X + m_normals[j].X) * num), Round((double)m_srcPoly[j].Y + (m_normals[k].Y + m_normals[j].Y) * num)));
		}

		internal void DoRound(int j, int k)
		{
			double value = Math.Atan2(m_sinA, m_normals[k].X * m_normals[j].X + m_normals[k].Y * m_normals[j].Y);
			int num = Math.Max((int)Round(m_StepsPerRad * Math.Abs(value)), 1);
			double num2 = m_normals[k].X;
			double num3 = m_normals[k].Y;
			for (int i = 0; i < num; i++)
			{
				m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + num2 * m_delta), Round((double)m_srcPoly[j].Y + num3 * m_delta)));
				double num4 = num2;
				num2 = num2 * m_cos - m_sin * num3;
				num3 = num4 * m_sin + num3 * m_cos;
			}
			m_destPoly.Add(new IntPoint(Round((double)m_srcPoly[j].X + m_normals[j].X * m_delta), Round((double)m_srcPoly[j].Y + m_normals[j].Y * m_delta)));
		}
	}

	private class ClipperException : Exception
	{
		public ClipperException(string description)
			: base(description)
		{
		}
	}
}

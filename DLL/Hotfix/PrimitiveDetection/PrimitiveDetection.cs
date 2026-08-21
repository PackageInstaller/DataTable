using System.Collections.Generic;
using Ase;
using UnityEngine;

namespace PrimitiveDetection;

[ExecuteInEditMode]
public class PrimitiveDetection : MonoBehaviour
{
	public PrimitiveEnum Enum;

	public float _radius = 1f;

	public float _interRadius = 0.5f;

	public float _height = 1f;

	public float _angle = 60f;

	public GameObject p1GameObject;

	public GameObject p2GameObject;

	public bool _result;

	public Color trueColor = Color.red;

	public Color falseColor = Color.green;

	private Dictionary<GameObject, BasePrimitive> PrimitivesDict = new Dictionary<GameObject, BasePrimitive>();

	private List<BasePrimitive> tempList = new List<BasePrimitive>();

	private void Start()
	{
		PrimitivesDict = new Dictionary<GameObject, BasePrimitive>();
		tempList = new List<BasePrimitive>();
		_result = false;
	}

	public void TestPolygon()
	{
		PolygonPrimitive item = PolygonPrimitive.Create(new List<Vector3>
		{
			new Vector3(10f, 0f, -5f),
			new Vector3(10f, 0f, 10f),
			new Vector3(0f, 0f, 10f)
		}, Vector3.zero, Quaternion.identity);
		tempList.Add(item);
	}

	public void TestSector()
	{
		SectorPrimitive sectorPrimitive = SectorPrimitive.Create(p1GameObject.transform.position, p1GameObject.transform.rotation, 220f, 1f);
		SectorPrimitive item = SectorPrimitive.Create(sectorPrimitive.SectorCenter, sectorPrimitive.Quaternion * Quaternion.Euler(new Vector3(0f, (0f - sectorPrimitive.Angle) * 57.29578f / 4f, 0f)), sectorPrimitive.Angle * 57.29578f / 2f, sectorPrimitive.Radius);
		tempList.Add(sectorPrimitive);
		tempList.Add(item);
	}

	public void BuildObject(int index)
	{
		_result = false;
		GameObject gameObject = index switch
		{
			1 => p1GameObject, 
			2 => p2GameObject, 
			_ => null, 
		};
		if (!(gameObject == null) && Enum != PrimitiveEnum.NONE)
		{
			if (PrimitivesDict.TryGetValue(gameObject, out var value))
			{
				value.OnDispose();
			}
			if (Enum == PrimitiveEnum.CapsulePrimitive)
			{
				CapsulePrimitive value2 = CapsulePrimitive.Create(gameObject.transform.position, gameObject.transform.rotation, _radius, _height);
				PrimitivesDict[gameObject] = value2;
			}
			else if (Enum == PrimitiveEnum.SpherePrimitive)
			{
				SpherePrimitive value3 = SpherePrimitive.Create(gameObject.transform.position, _radius, gameObject.transform.rotation);
				PrimitivesDict[gameObject] = value3;
			}
			else if (Enum == PrimitiveEnum.BoxPrimitive)
			{
				BoxPrimitive value4 = BoxPrimitive.Create(gameObject.transform.position, gameObject.transform.rotation, gameObject.transform.localScale / 2f);
				PrimitivesDict[gameObject] = value4;
			}
			else if (Enum == PrimitiveEnum.SectorPrimitive)
			{
				SectorPrimitive value5 = SectorPrimitive.Create(gameObject.transform.position, gameObject.transform.rotation, _angle, _radius);
				PrimitivesDict[gameObject] = value5;
			}
			else if (Enum == PrimitiveEnum.AnnulusPrimitive)
			{
				AnnulusPrimitive value6 = AnnulusPrimitive.Create(gameObject.transform.position, gameObject.transform.rotation, _angle, _radius, _interRadius);
				PrimitivesDict[gameObject] = value6;
			}
		}
	}

	public void DectectObject()
	{
		if (!(p1GameObject == null) && !(p2GameObject == null) && PrimitivesDict.ContainsKey(p1GameObject) && PrimitivesDict.ContainsKey(p2GameObject))
		{
			BasePrimitive basePrimitive = PrimitivesDict[p1GameObject];
			BasePrimitive p = PrimitivesDict[p2GameObject];
			bool result = false;
			switch (basePrimitive.PrimitiveType)
			{
			default:
				return;
			case PrimitiveEnum.NONE:
				return;
			case PrimitiveEnum.SectorPrimitive:
				SectorDetect((SectorPrimitive)basePrimitive, p, ref result);
				break;
			case PrimitiveEnum.BoxPrimitive:
				BoxDetect((BoxPrimitive)basePrimitive, p, ref result);
				break;
			case PrimitiveEnum.CapsulePrimitive:
				CapsuleDetect((CapsulePrimitive)basePrimitive, p, ref result);
				break;
			case PrimitiveEnum.SpherePrimitive:
				SphereDetect((SpherePrimitive)basePrimitive, p, ref result);
				break;
			case PrimitiveEnum.AnnulusPrimitive:
				AnnulusDetect((AnnulusPrimitive)basePrimitive, p, ref result);
				break;
			}
			_result = result;
		}
	}

	private void BoxDetect(BoxPrimitive box, BasePrimitive p2, ref bool result)
	{
		switch (p2.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			break;
		case PrimitiveEnum.SectorPrimitive:
		{
			result = IntersectionDetection.SectorAndBox((SectorPrimitive)p2, box, out var polygonPrimitive);
			polygonPrimitive?.OnDispose();
			break;
		}
		case PrimitiveEnum.BoxPrimitive:
			result = IntersectionDetection.BoxAndBox(box, (BoxPrimitive)p2);
			break;
		case PrimitiveEnum.CapsulePrimitive:
			result = IntersectionDetection.CapsuleAndBox((CapsulePrimitive)p2, box);
			break;
		case PrimitiveEnum.SpherePrimitive:
			result = IntersectionDetection.BoxAndSphere(box, (SpherePrimitive)p2);
			break;
		case PrimitiveEnum.AnnulusPrimitive:
			result = IntersectionDetection.AnnulusAndBox((AnnulusPrimitive)p2, box);
			break;
		}
	}

	private void SectorDetect(SectorPrimitive sector, BasePrimitive p2, ref bool result)
	{
		switch (p2.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			break;
		case PrimitiveEnum.BoxPrimitive:
		{
			result = IntersectionDetection.SectorAndBox(sector, (BoxPrimitive)p2, out var polygonPrimitive);
			polygonPrimitive?.OnDispose();
			break;
		}
		case PrimitiveEnum.CapsulePrimitive:
		{
			result = IntersectionDetection.SectorAndCapsule(sector, (CapsulePrimitive)p2, out var _);
			break;
		}
		case PrimitiveEnum.SpherePrimitive:
			result = IntersectionDetection.SectorAndSphere(sector, (SpherePrimitive)p2);
			break;
		case PrimitiveEnum.SectorPrimitive:
			break;
		}
	}

	private void CapsuleDetect(CapsulePrimitive capsule, BasePrimitive p2, ref bool result)
	{
		switch (p2.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			break;
		case PrimitiveEnum.SectorPrimitive:
		{
			result = IntersectionDetection.SectorAndCapsule((SectorPrimitive)p2, capsule, out var _);
			break;
		}
		case PrimitiveEnum.BoxPrimitive:
			result = IntersectionDetection.CapsuleAndBox(capsule, (BoxPrimitive)p2);
			break;
		case PrimitiveEnum.CapsulePrimitive:
			result = IntersectionDetection.CapsuleAndCapsule((CapsulePrimitive)p2, capsule);
			break;
		case PrimitiveEnum.SpherePrimitive:
			result = IntersectionDetection.CapsuleAndSphere(capsule, (SpherePrimitive)p2);
			break;
		case PrimitiveEnum.AnnulusPrimitive:
			result = IntersectionDetection.AnnulusAndCapusle((AnnulusPrimitive)p2, capsule);
			break;
		}
	}

	private void SphereDetect(SpherePrimitive sphere, BasePrimitive p2, ref bool result)
	{
		switch (p2.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			break;
		case PrimitiveEnum.SectorPrimitive:
			result = IntersectionDetection.SectorAndSphere((SectorPrimitive)p2, sphere);
			break;
		case PrimitiveEnum.BoxPrimitive:
			result = IntersectionDetection.BoxAndSphere((BoxPrimitive)p2, sphere);
			break;
		case PrimitiveEnum.CapsulePrimitive:
			result = IntersectionDetection.CapsuleAndSphere((CapsulePrimitive)p2, sphere);
			break;
		case PrimitiveEnum.SpherePrimitive:
			result = IntersectionDetection.SphereAndSphere(sphere, (SpherePrimitive)p2);
			break;
		case PrimitiveEnum.AnnulusPrimitive:
			result = IntersectionDetection.AnnulusAndSphere((AnnulusPrimitive)p2, sphere);
			break;
		}
	}

	private void AnnulusDetect(AnnulusPrimitive p1, BasePrimitive p2, ref bool result)
	{
		switch (p2.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			break;
		case PrimitiveEnum.BoxPrimitive:
			result = IntersectionDetection.AnnulusAndBox(p1, (BoxPrimitive)p2);
			break;
		case PrimitiveEnum.CapsulePrimitive:
			result = IntersectionDetection.AnnulusAndCapusle(p1, (CapsulePrimitive)p2);
			break;
		case PrimitiveEnum.SpherePrimitive:
			result = IntersectionDetection.AnnulusAndSphere(p1, (SpherePrimitive)p2);
			break;
		}
	}

	public PrimitiveEnum GetPrimitiveByIdx(int idx)
	{
		switch (idx)
		{
		case 1:
		{
			if (!p1GameObject || !PrimitivesDict.TryGetValue(p1GameObject, out var _))
			{
				return PrimitiveEnum.NONE;
			}
			return PrimitivesDict[p1GameObject].PrimitiveType;
		}
		case 2:
		{
			if (!p2GameObject || !PrimitivesDict.TryGetValue(p2GameObject, out var _))
			{
				return PrimitiveEnum.NONE;
			}
			return PrimitivesDict[p2GameObject].PrimitiveType;
		}
		default:
			return PrimitiveEnum.NONE;
		}
	}

	public void DrawResult()
	{
	}

	private void Update()
	{
	}
}

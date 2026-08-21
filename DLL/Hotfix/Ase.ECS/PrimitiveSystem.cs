using System;
using System.Collections.Generic;
using GameFramework;
using PrimitiveDetection;
using UnityEngine;

namespace Ase.ECS;

public class PrimitiveSystem
{
	private static bool CheckPrimitiveType(PrimitiveEnum primitiveEnum, out Type pType)
	{
		switch (primitiveEnum)
		{
		case PrimitiveEnum.NONE:
			pType = null;
			return false;
		case PrimitiveEnum.BoxPrimitive:
			pType = typeof(BoxPrimitive);
			return true;
		case PrimitiveEnum.CapsulePrimitive:
			pType = typeof(CapsulePrimitive);
			return true;
		case PrimitiveEnum.SpherePrimitive:
			pType = typeof(SpherePrimitive);
			return true;
		case PrimitiveEnum.SectorPrimitive:
			pType = typeof(SectorPrimitive);
			return true;
		case PrimitiveEnum.AnnulusPrimitive:
			pType = typeof(AnnulusPrimitive);
			return true;
		default:
			pType = null;
			return false;
		}
	}

	public static bool IsIntersect(BasePrimitive one, BasePrimitive two)
	{
		bool result = false;
		if (one == null || two == null)
		{
			return false;
		}
		if (!one.InternalCheckPrimitive() || !two.InternalCheckPrimitive())
		{
			return false;
		}
		switch (one.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			return false;
		case PrimitiveEnum.SectorPrimitive:
			SectorDetect((SectorPrimitive)one, two, ref result);
			break;
		case PrimitiveEnum.BoxPrimitive:
			BoxDetect((BoxPrimitive)one, two, ref result);
			break;
		case PrimitiveEnum.CapsulePrimitive:
			CapsuleDetect((CapsulePrimitive)one, two, ref result);
			break;
		case PrimitiveEnum.SpherePrimitive:
			SphereDetect((SpherePrimitive)one, two, ref result);
			break;
		case PrimitiveEnum.AnnulusPrimitive:
			AnnulusDetect((AnnulusPrimitive)one, two, ref result);
			break;
		default:
			return false;
		}
		return result;
	}

	public static bool IsIntersect(PrimitiveInfo p1, PrimitiveInfo p2)
	{
		BasePrimitive basePrimitive = CreatePrimitive(p1);
		BasePrimitive basePrimitive2 = CreatePrimitive(p2);
		bool result = false;
		if (basePrimitive == null || basePrimitive2 == null)
		{
			return false;
		}
		if (!basePrimitive.InternalCheckPrimitive() || !basePrimitive2.InternalCheckPrimitive())
		{
			return false;
		}
		switch (basePrimitive.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			return false;
		case PrimitiveEnum.SectorPrimitive:
			SectorDetect((SectorPrimitive)basePrimitive, basePrimitive2, ref result);
			break;
		case PrimitiveEnum.BoxPrimitive:
			BoxDetect((BoxPrimitive)basePrimitive, basePrimitive2, ref result);
			break;
		case PrimitiveEnum.CapsulePrimitive:
			CapsuleDetect((CapsulePrimitive)basePrimitive, basePrimitive2, ref result);
			break;
		case PrimitiveEnum.SpherePrimitive:
			SphereDetect((SpherePrimitive)basePrimitive, basePrimitive2, ref result);
			break;
		case PrimitiveEnum.AnnulusPrimitive:
			AnnulusDetect((AnnulusPrimitive)basePrimitive, basePrimitive2, ref result);
			break;
		default:
			return false;
		}
		basePrimitive.OnDispose();
		basePrimitive2.OnDispose();
		return result;
	}

	public static bool IsIntersect(Vector3 point, Vector3 direct, BasePrimitive one)
	{
		bool result = false;
		if (one == null)
		{
			return false;
		}
		if (!one.InternalCheckPrimitive())
		{
			return false;
		}
		switch (one.PrimitiveType)
		{
		case PrimitiveEnum.NONE:
			return false;
		case PrimitiveEnum.BoxPrimitive:
			result = IntersectionDetection.BoxAndRay(point, direct, (BoxPrimitive)one);
			break;
		case PrimitiveEnum.CapsulePrimitive:
			result = IntersectionDetection.CapsuleAndRay(point, direct, (CapsulePrimitive)one);
			break;
		case PrimitiveEnum.SpherePrimitive:
			result = IntersectionDetection.SphereAndRay(point, direct, (SpherePrimitive)one);
			break;
		default:
			return false;
		case PrimitiveEnum.SectorPrimitive:
		case PrimitiveEnum.AnnulusPrimitive:
			break;
		}
		return result;
	}

	public static BasePrimitive CreatePrimitive(PrimitiveInfo info)
	{
		if (!CheckPrimitiveType(info.Type, out var pType))
		{
			return null;
		}
		BasePrimitive obj = (BasePrimitive)ReferencePool.Acquire(pType);
		obj.OnInit(info, out var _);
		return obj;
	}

	private static void BoxDetect(BoxPrimitive box, BasePrimitive p2, ref bool result)
	{
		if (p2 != null)
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
	}

	private static void SectorDetect(SectorPrimitive sector, BasePrimitive p2, ref bool result)
	{
		if (p2 != null)
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
	}

	private static void CapsuleDetect(CapsulePrimitive capsule, BasePrimitive p2, ref bool result)
	{
		if (p2 != null)
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
	}

	private static void SphereDetect(SpherePrimitive sphere, BasePrimitive p2, ref bool result)
	{
		if (p2 != null)
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
	}

	private static void AnnulusDetect(AnnulusPrimitive p1, BasePrimitive p2, ref bool result)
	{
		if (p2 != null)
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
	}

	public static PrimitiveInfo InitPrimitiveInfo(ref PrimitiveInfo info, List<float> param)
	{
		switch (info.Type)
		{
		case PrimitiveEnum.BoxPrimitive:
			if (param.Count >= 3)
			{
				info.BoxSize = new Vector3(param[0], param[1], param[2]);
			}
			break;
		case PrimitiveEnum.CapsulePrimitive:
			if (param.Count >= 2)
			{
				info.Radius = param[0];
				info.Height = param[1];
			}
			break;
		case PrimitiveEnum.SpherePrimitive:
			if (param.Count >= 1)
			{
				info.Radius = param[0];
			}
			break;
		case PrimitiveEnum.SectorPrimitive:
			if (param.Count >= 2)
			{
				info.Radius = param[0];
				info.Angle = param[1];
			}
			break;
		case PrimitiveEnum.AnnulusPrimitive:
			if (param.Count >= 3)
			{
				info.InternalRadius = param[0];
				info.Radius = param[1];
				info.Angle = param[2];
			}
			break;
		}
		return info;
	}
}

using System.Collections.Generic;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractPath : StateObjectBase
{
	private InteractPathData m_Data;

	private Dictionary<AssetLoadHandle, (float, Vector3, Vector3)> m_LastModelObjDic = new Dictionary<AssetLoadHandle, (float, Vector3, Vector3)>();

	private Dictionary<AssetLoadHandle, (float, Vector3, Vector3)> m_ModelObjDic = new Dictionary<AssetLoadHandle, (float, Vector3, Vector3)>();

	private Dictionary<AssetLoadHandle, int> m_LinkObjDic = new Dictionary<AssetLoadHandle, int>();

	private List<AssetLoadHandle> m_LastModelObjs = new List<AssetLoadHandle>();

	private List<AssetLoadHandle> m_ModelObjs = new List<AssetLoadHandle>();

	private List<AssetLoadHandle> m_LinkObjs = new List<AssetLoadHandle>();

	private Vector3 m_Dir;

	private float m_Dis;

	private Vector3 m_StartPoint;

	private Vector3 m_EndPoint;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is InteractPathData data))
		{
			return;
		}
		m_Data = data;
		for (int i = 0; i < m_Data.poses.Length - 1; i++)
		{
			Pos[] poses = m_Data.poses;
			m_StartPoint = poses[i].value;
			m_EndPoint = poses[i + 1].value;
			m_Dis = (m_EndPoint - m_StartPoint).magnitude;
			m_Dir = m_EndPoint - m_StartPoint;
			GameObject gameObject = new GameObject($"Path:{i + 1}");
			gameObject.transform.parent = transform;
			if (poses.Length > 2 && i + 1 < poses.Length - 1)
			{
				AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.InstantiateAsync(m_Data.linkModelAssetID, transform);
				assetLoadHandle.Completed += LinkObjCompleted;
				m_LinkObjDic.Add(assetLoadHandle, i + 1);
				m_LinkObjs.Add(assetLoadHandle);
			}
			for (float num = 1f; num < m_Dis; num += m_Data.width)
			{
				AssetLoadHandle assetLoadHandle2 = AssetStationManager.BattleStation.InstantiateAsync(m_Data.unitModelAssetID, gameObject.transform);
				assetLoadHandle2.Completed += ModelObjCompleted;
				m_ModelObjDic.Add(assetLoadHandle2, (num, m_StartPoint, m_Dir));
				m_ModelObjs.Add(assetLoadHandle2);
			}
			if (m_Dis - Mathf.Floor(m_Dis) > 0f)
			{
				AssetLoadHandle assetLoadHandle3 = AssetStationManager.BattleStation.InstantiateAsync(m_Data.unitModelAssetID, gameObject.transform);
				assetLoadHandle3.Completed += LastModelObjCompleted;
				m_LastModelObjDic.Add(assetLoadHandle3, (m_Dis, m_EndPoint, m_Dir));
				m_LastModelObjs.Add(assetLoadHandle3);
			}
			GameObject gameObject2 = new GameObject("collider");
			gameObject2.transform.parent = gameObject.transform;
			gameObject2.transform.rotation = Quaternion.LookRotation(m_Dir);
			gameObject2.transform.position = (m_StartPoint + m_EndPoint) / 2f;
			gameObject2.AddComponent<BoxCollider>().size = new Vector3(1f, 0.15f, m_Dis);
		}
		base.InitStateObject(stateId);
	}

	private void LinkObjCompleted(AssetLoadHandle obj)
	{
		m_LinkObjDic.TryGetValue(obj, out var value);
		obj.AsGameObject().transform.position = m_Data.poses[value].value;
	}

	private void ModelObjCompleted(AssetLoadHandle obj)
	{
		GameObject gameObject = obj.AsGameObject();
		m_ModelObjDic.TryGetValue(obj, out var value);
		Vector3 position = m_Data.width / 2f * (2f * value.Item1 - 1f) * value.Item3.normalized + value.Item2;
		Quaternion rotation = Quaternion.LookRotation(value.Item3) * gameObject.transform.rotation;
		gameObject.transform.position = position;
		gameObject.transform.rotation = rotation;
	}

	private void LastModelObjCompleted(AssetLoadHandle obj)
	{
		GameObject gameObject = obj.AsGameObject();
		m_LastModelObjDic.TryGetValue(obj, out var value);
		float num = value.Item1 - Mathf.Floor(value.Item1);
		Vector3 position = value.Item2 - num / 2f * value.Item3.normalized;
		Quaternion rotation = Quaternion.LookRotation(value.Item3) * gameObject.transform.rotation;
		Vector3 localScale = gameObject.transform.localScale;
		localScale = new Vector3(localScale.z, localScale.y, num);
		gameObject.transform.localScale = localScale;
		gameObject.transform.position = position;
		gameObject.transform.rotation = rotation;
	}

	public override void ReleaseStateObject()
	{
		for (int num = m_ModelObjs.Count - 1; num >= 0; num--)
		{
			if (AssetLoadHandleExtensions.IsValid(m_ModelObjs[num]))
			{
				AssetLoadHandle assetLoadHandle = m_ModelObjs[num];
				assetLoadHandle.Completed -= ModelObjCompleted;
				AssetStationManager.BattleStation.ReleaseInstance(m_ModelObjs[num]);
			}
		}
		m_ModelObjs.Clear();
		for (int num2 = m_LinkObjs.Count - 1; num2 >= 0; num2--)
		{
			if (AssetLoadHandleExtensions.IsValid(m_LinkObjs[num2]))
			{
				AssetLoadHandle assetLoadHandle = m_LinkObjs[num2];
				assetLoadHandle.Completed -= LinkObjCompleted;
				AssetStationManager.BattleStation.ReleaseInstance(m_LinkObjs[num2]);
			}
		}
		m_LinkObjs.Clear();
		for (int num3 = m_LastModelObjs.Count - 1; num3 >= 0; num3--)
		{
			if (AssetLoadHandleExtensions.IsValid(m_LastModelObjs[num3]))
			{
				AssetLoadHandle assetLoadHandle = m_LastModelObjs[num3];
				assetLoadHandle.Completed -= LastModelObjCompleted;
				AssetStationManager.BattleStation.ReleaseInstance(m_LastModelObjs[num3]);
			}
		}
		m_LastModelObjs.Clear();
		base.ReleaseStateObject();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}

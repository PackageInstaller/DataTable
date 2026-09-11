using System.Collections.Generic;
using Dorm;
using UnityEngine;

public class QWFurnitureBlackboard : QWBlackboard
{
	public const string ATTACH_POINT_PREFIX = "gua_";

	public const string ROOT = "root";

	public const string ANIME_ACTION_SCHEME = "(.+\\D)\\d*$";

	private bool isInit;

	public QWFurnitureTag dormTag;

	private Dictionary<Transform, Transform> selfAttachedItems;

	public bool inInteract;

	public bool interactExitDirty;

	public bool waitInteractExit;

	private int mFId;

	private InteractAction mInteractAction;

	private InteractAction mExitInteractAction;

	public Dictionary<string, Transform> furnitureAttachPoint;

	public int FurnitureId => mFId;

	public int InteractAction => mInteractAction.id;

	public int ExitInteractAction => mExitInteractAction.id;

	public Transform InteractActionTrans => mInteractAction.interactPos;

	public Transform GetFurnitureAttachPoint(string path)
	{
		if (furnitureAttachPoint == null || furnitureAttachPoint.Count == 0)
		{
			furnitureAttachPoint = new Dictionary<string, Transform>();
			furnitureAttachPoint.Add("root", base.transform);
			CollectAttachPoints(furnitureAttachPoint, base.transform);
			selfAttachedItems = CollectItemPart(furnitureAttachPoint);
		}
		furnitureAttachPoint.TryGetValue(path, out var value);
		return value;
	}

	public Transform FindItem(string itemName)
	{
		if (selfAttachedItems == null || selfAttachedItems.Count == 0)
		{
			if (furnitureAttachPoint == null)
			{
				furnitureAttachPoint = new Dictionary<string, Transform>();
				furnitureAttachPoint.Add("root", base.transform);
				CollectAttachPoints(furnitureAttachPoint, base.transform);
			}
			selfAttachedItems = CollectItemPart(furnitureAttachPoint);
		}
		foreach (Transform key in selfAttachedItems.Keys)
		{
			if (key.name == itemName)
			{
				return key;
			}
		}
		return null;
	}

	private void CollectAttachPoints(Dictionary<string, Transform> attachPoints, Transform trans)
	{
		if (trans.name.StartsWith("gua_"))
		{
			attachPoints.Add(trans.name, trans);
		}
		foreach (Transform tran in trans)
		{
			CollectAttachPoints(attachPoints, tran);
		}
	}

	public override Transform GetHudPoint()
	{
		if (dormTag != null)
		{
			return dormTag.hudPivot;
		}
		return null;
	}

	public override void OnFirstAddToStage(GameObject obj)
	{
		QWFurnitureTag component = obj.GetComponent<QWFurnitureTag>();
		if (component != null)
		{
			dormTag = component;
			mFId = component.id;
			for (int i = 0; i < component.interactActions.Length; i++)
			{
				if (component.interactActions[i].id > 0)
				{
					mInteractAction = component.interactActions[i];
					break;
				}
			}
			mExitInteractAction = component.exitAction;
			interactExitDirty = false;
			inInteract = false;
			waitInteractExit = false;
		}
		furnitureAttachPoint = null;
		selfAttachedItems = null;
		animator = GetComponentInChildren<Animator>();
		isInit = true;
	}

	public override void OnRemoveToStage()
	{
		base.OnRemoveToStage();
		dormTag = null;
		animator = null;
		selfAttachedItems?.Clear();
		furnitureAttachPoint?.Clear();
	}

	public override void InitBlackboard()
	{
		mFId = 0;
		mInteractAction = default(InteractAction);
		isInit = false;
		interactExitDirty = false;
		inInteract = false;
		waitInteractExit = false;
	}

	public override void ResetBlackboard()
	{
		base.ResetBlackboard();
		mFId = 0;
		mInteractAction = default(InteractAction);
		isInit = false;
		interactExitDirty = false;
		inInteract = false;
		waitInteractExit = false;
	}

	private static Dictionary<Transform, Transform> CollectItemPart(Dictionary<string, Transform> attachPoints)
	{
		Dictionary<Transform, Transform> dictionary = new Dictionary<Transform, Transform>();
		foreach (KeyValuePair<string, Transform> attachPoint in attachPoints)
		{
			Transform value = attachPoint.Value;
			foreach (Transform item in value)
			{
				if (item.CompareTag("Item"))
				{
					dictionary.Add(item, value);
				}
			}
		}
		return dictionary;
	}
}

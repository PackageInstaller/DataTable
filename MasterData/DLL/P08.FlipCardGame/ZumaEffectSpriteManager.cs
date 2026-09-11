using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaEffectSpriteManager : ZumaSpriteBaseMgr
{
	public ZumaPool<ZumaAnimator> effectPool;

	public GameObject effectObj;

	public Transform effectNode;

	private List<ZumaAnimator> useEffectList = new List<ZumaAnimator>();

	public Transform prefabEffectNode;

	public GameObject comboEffectObj;

	public ZumaPool<PrefabEffectItem> comboPool;

	private List<PrefabEffectItem> usePrebabEffectList = new List<PrefabEffectItem>();

	public override void AwakeInit()
	{
		effectPool = new ZumaPool<ZumaAnimator>(InstanceEffectFunc, 5);
		comboPool = new ZumaPool<PrefabEffectItem>(InstanceComboFunc, 5);
		ZumaGameManager.GetInstance().SetEffectSpriteManager(this);
	}

	private PrefabEffectItem InstanceComboFunc()
	{
		PrefabEffectItem prefabEffectItem = new PrefabEffectItem();
		prefabEffectItem.Init(Object.Instantiate(comboEffectObj, prefabEffectNode));
		return prefabEffectItem;
	}

	public void ShowComboEffect(Vector3 beginPos, Vector3 toPos)
	{
		PrefabEffectItem ballObj = comboPool.GetBallObj();
		ballObj.BeginShow(beginPos, toPos);
		usePrebabEffectList.Add(ballObj);
	}

	private ZumaAnimator InstanceEffectFunc()
	{
		return Object.Instantiate(effectObj, effectNode).GetComponent<ZumaAnimator>();
	}

	public void ShowEffect(Vector3 pos, FrameType frameType, BallColorType colorType)
	{
		ZumaAnimator ballObj = effectPool.GetBallObj();
		ballObj.transform.position = pos;
		ballObj.ChangeFrameList(GetFrameSprite(frameType, colorType));
		useEffectList.Add(ballObj);
	}

	private void Update()
	{
		int count = useEffectList.Count;
		while (count-- > 0)
		{
			ZumaAnimator zumaAnimator = useEffectList[count];
			if (zumaAnimator.CheckIsFinish())
			{
				useEffectList.RemoveAt(count);
				effectPool.AddObject(zumaAnimator);
				ZumaGameManager.IsShowObj(zumaAnimator.transform, isShow: false);
			}
		}
		int count2 = usePrebabEffectList.Count;
		while (count2-- > 0)
		{
			PrefabEffectItem prefabEffectItem = usePrebabEffectList[count2];
			prefabEffectItem.Process();
			if (!prefabEffectItem.isShow)
			{
				comboPool.AddObject(prefabEffectItem);
				usePrebabEffectList.RemoveAt(count2);
			}
		}
	}
}

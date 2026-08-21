using Cinemachine;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Playables;

namespace T0World;

public class T0InterationQteTips : MonoBehaviour
{
	private DragOnSmoothPathHandler handler;

	private TimelineProcessController timelineController;

	private GameObject uiEffectObj;

	public void CreatePosNode(T0InterationQTEData qteData)
	{
		handler.nodes = new Transform[qteData.pathList.Count];
		for (int i = 0; i < qteData.pathList.Count; i++)
		{
			GameObject gameObject = new GameObject(i.ToString());
			gameObject.transform.parent = base.transform;
			gameObject.transform.localPosition = qteData.pathList[i];
			handler.nodes[i] = gameObject.transform;
		}
	}

	public void InitQTE(T0InterationQTEData qteData)
	{
		BoxCollider boxCollider = base.gameObject.AddComponent<BoxCollider>();
		boxCollider.center = qteData.center;
		boxCollider.size = qteData.size;
		boxCollider.isTrigger = true;
		base.gameObject.AddComponent<CinemachineSmoothPath>();
		handler = base.gameObject.AddComponent<DragOnSmoothPathHandler>();
		CreatePosNode(qteData);
		handler.onDragFinish = new UnityEvent();
		handler.onDragFinish.AddListener(delegate
		{
			qteData.IsFinish = true;
		});
		handler.onValueChange = new UnityEvent<float>();
		handler.onValueChange.AddListener(delegate(float value)
		{
			if (timelineController != null)
			{
				timelineController.PlayFromProgress(value);
			}
		});
		handler.Invoke();
	}

	public void InitTimeline(HeroUITimelineBrain brain, GameObject timelinePrafab)
	{
		GameObject obj = Object.Instantiate(timelinePrafab, base.transform);
		obj.transform.SetParent(base.transform);
		obj.transform.localPosition = Vector3.zero;
		obj.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
		obj.transform.localScale = Vector3.one;
		PlayableDirector component = obj.GetComponent<PlayableDirector>();
		brain.BindPlayableDirector(component);
		brain.RebuildPlayableDirector(component);
		component.Evaluate();
		timelineController = brain.transform.GetComponentInChildren<TimelineProcessController>();
	}

	public void InitQTEUITips(GameObject uiPrefab, Vector3 ui_pos)
	{
		Transform effectNode = T0WorldScene.Scene.mWorldUI.effectNode;
		uiEffectObj = Object.Instantiate(uiPrefab, effectNode);
		uiEffectObj.transform.localPosition = ui_pos;
	}

	public void Dispose()
	{
		if (uiEffectObj != null)
		{
			Object.DestroyImmediate(uiEffectObj);
		}
		Object.DestroyImmediate(base.gameObject);
	}
}

using ACT.Config;
using ACT.Core;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class RogueInteractTip : MonoBehaviour
{
	public LocalizeStringEvent TextTips;

	private StateObjectBase _stateObjectBase;

	private RogueElement _rogueElement;

	private void Start()
	{
	}

	public void Init(StateObjectBase stateObjectBase, int id)
	{
		_stateObjectBase = stateObjectBase;
		Refresh(id);
	}

	public void Refresh(int id)
	{
		_rogueElement = CoreUtils.GetData(id, RuntimeConfigs.data.rogueElements);
		if (_rogueElement != null)
		{
			TextTips.StringReference.TableEntryReference = _rogueElement.description;
		}
	}

	public void UpdatePos()
	{
		Vector3 direction = new Vector3(0f, 2f, 0f);
		direction.y += _stateObjectBase.entity.GetCompTransform().size.y;
		Transform rootTransform = _stateObjectBase.entity.GetRootTransform();
		direction = rootTransform.TransformDirection(direction);
		Vector3 position = GameUtility.mainCamera.WorldToScreenPoint(rootTransform.position + direction);
		position.z = transform.position.z;
		transform.position = GameUtility.uiCamera.ScreenToWorldPoint(position);
	}

	private void Update()
	{
	}
}

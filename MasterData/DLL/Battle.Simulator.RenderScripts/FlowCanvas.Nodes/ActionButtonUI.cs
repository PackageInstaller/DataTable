using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("行动键(渲染)", 0)]
[Category("Render/UI")]
[Description("行动键;\n 互动触发区域\n 没有走过移除的话, 再添加是没有用的")]
public class ActionButtonUI : EffectCreateBaseNode
{
	private GameObject _GameObjectToHide;

	private void Show(bool flag)
	{
		if (_effectInstance != null)
		{
			_effectInstance.SetActive(flag);
		}
		if (_GameObjectToHide != null)
		{
			_GameObjectToHide.SetActive(!flag);
		}
	}

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		FlowOutput _Bind = AddFlowOutput("初始化");
		FlowOutput _Active = AddFlowOutput("显示");
		FlowOutput _Disable = AddFlowOutput("隐藏");
		FlowOutput _Leave = AddFlowOutput("移除");
		FlowOutput _Click = AddFlowOutput("点击");
		FlowOutput _Error = AddFlowOutput("Error");
		ValueInput<string> _ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer");
		ValueInput<string> _GameObjectToHidePathInput = AddValueInput<string>("要隐藏的对象路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/BattleButtons");
		AddFlowInput("初始化", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(_effectPathInput.GetValue()))
			{
				_Error.Call(f);
			}
			else
			{
				GameObject gameObject = null;
				if (_effectInstance == null && !string.IsNullOrEmpty(_ChildPanelPathInput.GetValue()))
				{
					BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
					if (battleScene != null && battleScene.battlePanelGameObject != null)
					{
						gameObject = battleScene.battlePanelGameObject;
						Transform transform = gameObject.transform.Find(_ChildPanelPathInput.GetValue());
						if (transform != null)
						{
							gameObject = transform.gameObject;
						}
					}
				}
				if (gameObject == null)
				{
					_Error.Call(f);
				}
				else
				{
					if (_effectInstance == null)
					{
						GameObject gameObject2 = Asset.Instantiate(_effectPathInput.GetValue());
						if (gameObject2 == null)
						{
							_Error.Call(f);
							return;
						}
						gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: false);
						_effectInstance = gameObject2;
						_effectInstance.SetActive(value: false);
						P08EXButton com = gameObject2.GetComponent<P08EXButton>();
						if (com != null)
						{
							com.actionOnPointerUp = delegate
							{
								_Click.Call(f);
								com.actionOnPointerUp = null;
							};
						}
					}
					if (_GameObjectToHide == null && !string.IsNullOrEmpty(_GameObjectToHidePathInput.value))
					{
						BattleScene battleScene2 = NScene.GetCurrentScene() as BattleScene;
						if (battleScene2 != null && battleScene2.battlePanelGameObject != null)
						{
							Transform transform2 = battleScene2.battlePanelGameObject.transform.Find(_GameObjectToHidePathInput.value);
							if (transform2 != null)
							{
								_GameObjectToHide = transform2.gameObject;
							}
						}
					}
					Show(flag: false);
					_Bind.Call(f);
				}
			}
		});
		AddFlowInput("显示", delegate(Flow f)
		{
			Show(flag: true);
			if (_effectInstance != null)
			{
				P08EXButton com = _effectInstance.GetComponent<P08EXButton>();
				if (com != null && com.actionOnPointerUp == null)
				{
					com.actionOnPointerUp = delegate
					{
						_Click.Call(f);
						com.actionOnPointerUp = null;
					};
				}
			}
			_Active.Call(f);
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			Show(flag: false);
			_Disable.Call(f);
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			Show(flag: false);
			PooledAsset.DestroyOrReturn(_effectInstance);
			_effectInstance = null;
			_GameObjectToHide = null;
			_Leave.Call(f);
		});
	}
}

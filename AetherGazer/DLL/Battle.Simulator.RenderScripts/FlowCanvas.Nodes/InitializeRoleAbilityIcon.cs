using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("初始化角色UI数据(过时)", 0)]
[Category("Render/UI")]
[Description("初始化角色UI数据")]
public class InitializeRoleAbilityIcon : CallableActionNode<int, List<int>, GameObject>
{
	public override void Invoke(int entityID, List<int> abilities, GameObject panel)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			Debug.LogError("Can't Find Entity By " + entityID);
			return;
		}
		int mId = entityWithEntityID.entityConfig.mId;
		RoleConfig roleConfig = entityWithEntityID.entityConfig.mConfig as RoleConfig;
		string atlasName = "Atlas/" + mId;
		for (int i = 0; i < roleConfig.Ability.Count; i++)
		{
			int num = i + 1;
			Transform transform = panel.transform.Find(string.Format("AbilityButtons/btn_skill{0}/skill{0}_img", num));
			if (transform != null)
			{
				Image component = transform.GetComponent<Image>();
				Sprite sprite = AtlasManager.GetSprite(atlasName, roleConfig.Ability.get_Item(i).ToString());
				if (null != sprite)
				{
					component.sprite = sprite;
				}
				abilities[i] = roleConfig.Ability.get_Item(i);
			}
		}
	}
}

local var_0_0 = class("HeroCooperationItemItem", ReduxView)
local var_0_1 = {
	"Effect/SourceSpaceScene/X05",
	"Effect/SourceSpaceScene/X03",
	"Effect/SourceSpaceScene/X02",
	"Effect/SourceSpaceScene/X04",
	"Effect/SourceSpaceScene/X06",
	nil,
	nil,
	nil,
	"Effect/SourceSpaceScene/X07"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitUI()
	arg_1_0:AddUIListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_2_0.headControllerList = {
		arg_2_0.head1Controller_:GetController("state"),
		arg_2_0.head2Controller_:GetController("state"),
		(arg_2_0.head3Controller_:GetController("state"))
	}
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.playBtn_, nil, function()
		local var_4_0 = {}
		local var_4_1 = HeroCfg[arg_3_0.selectHeroId]
		local var_4_2 = Asset.Load(var_0_1[var_4_1.race])
		local var_4_3 = GameObject.Instantiate(var_4_2)

		var_4_3:GetComponent(typeof(PooledAsset)):SetActive(true)

		var_4_3.layer = LayerMask.NameToLayer("Default")

		local var_4_4 = var_4_3:GetComponentsInChildren(typeof(Transform), true)

		for iter_4_0, iter_4_1 in pairs(var_4_4:ToTable()) do
			iter_4_1.gameObject.layer = LayerMask.NameToLayer("Default")
		end

		SceneManager.MoveGameObjectToScene(var_4_3, SceneManager.GetSceneByName("X109"))
		table.insert(var_4_0, {
			obj = var_4_3,
			path = var_0_1[var_4_1.race]
		})

		for iter_4_2, iter_4_3 in ipairs(arg_3_0.heroIDList) do
			SetActive(arg_3_0[string.format("head%sGo_", iter_4_2)], true)

			local var_4_5 = arg_3_0.heroViewProxy_:GetHeroUsingSkinInfo(iter_4_3).id

			if var_4_5 < 10000 then
				var_4_5 = var_4_5 * 100
			end

			local var_4_6 = "CooperateUniqueSkillTimeline/" .. var_4_5 .. "/" .. arg_3_0.cfg.prefab_path
			local var_4_7 = Asset.Load(var_4_6)
			local var_4_8 = GameObject.Instantiate(var_4_7)

			var_4_8:GetComponent(typeof(PooledAsset)):SetActive(true)
			table.insert(var_4_0, {
				obj = var_4_8,
				path = var_4_6
			})
		end

		local var_4_9 = arg_3_0.heroIDList[1]

		if var_4_9 < 10000 then
			var_4_9 = var_4_9 * 100
		end

		arg_3_0.callBack(var_4_0, var_4_9, arg_3_0.cfg.prefab_path)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.data = arg_5_1
	arg_5_0.cfg = ComboSkillCfg[arg_5_1]
	arg_5_0.skillCfg = HeroSkillCfg[arg_5_0.cfg.skill_id]
	arg_5_0.callBack = arg_5_2
	arg_5_0.selectHeroId = arg_5_3

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.skillIcon_.sprite = getSpriteViaConfig("ComboSkill", arg_6_0.cfg.skill_id)
	arg_6_0.skillName_.text = GetI18NText(arg_6_0.skillCfg.name)
	arg_6_0.heroIDList = deepClone(arg_6_0.cfg.cooperate_role_ids)

	CommonTools.UniversalSortEx(arg_6_0.heroIDList, {
		map = function(arg_7_0)
			return arg_7_0
		end
	})

	for iter_6_0 = 1, 3 do
		SetActive(arg_6_0[string.format("head%sGo_", iter_6_0)], false)
	end

	for iter_6_1, iter_6_2 in ipairs(arg_6_0.heroIDList) do
		arg_6_0.headControllerList[iter_6_1]:SetSelectedState(arg_6_0.heroViewProxy_:GetHeroData(iter_6_2).unlock == 1 and "on" or "off")
		SetActive(arg_6_0[string.format("head%sGo_", iter_6_1)], true)

		local var_6_0 = arg_6_0.heroViewProxy_:GetHeroUsingSkinInfo(iter_6_2).id

		arg_6_0[string.format("head%sIcon_", iter_6_1)].sprite = getSpriteViaConfig("HeroItemshead", var_6_0)
	end
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.list then
		arg_8_0.list:Dispose()

		arg_8_0.list = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0

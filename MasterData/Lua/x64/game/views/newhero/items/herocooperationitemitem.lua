local HeroCooperationItemItem = class("HeroCooperationItemItem", ReduxView)
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

function HeroCooperationItemItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:InitUI()
	self:AddUIListeners()
end

function HeroCooperationItemItem:InitUI()
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.headControllerList = {
		self.head1Controller_:GetController("state"),
		self.head2Controller_:GetController("state"),
		(self.head3Controller_:GetController("state"))
	}
end

function HeroCooperationItemItem:AddUIListeners()
	self:AddBtnListener(self.playBtn_, nil, function()
		local var_4_0 = {}
		local var_4_1 = GameObject.Instantiate((Asset.Load(var_0_1[HeroCfg[self.selectHeroId].race])))

		var_4_1:GetComponent(typeof(PooledAsset)):SetActive(true)

		var_4_1.layer = LayerMask.NameToLayer("Default")

		for iter_4_0, iter_4_1 in pairs(var_4_1:GetComponentsInChildren(typeof(Transform), true):ToTable()) do
			iter_4_1.gameObject.layer = LayerMask.NameToLayer("Default")
		end

		SceneManager.MoveGameObjectToScene(var_4_1, SceneManager.GetSceneByName("X109"))
		table.insert(var_4_0, {
			obj = var_4_1,
			path = var_0_1[HeroCfg[self.selectHeroId].race]
		})

		for iter_4_2, iter_4_3 in ipairs(self.heroIDList) do
			SetActive(self[string.format("head%sGo_", iter_4_2)], true)

			local var_4_2 = self.heroViewProxy_:GetHeroUsingSkinInfo(iter_4_3).id

			if var_4_2 < 10000 then
				var_4_2 = var_4_2 * 100
			end

			local var_4_3 = "CooperateUniqueSkillTimeline/" .. var_4_2 .. "/" .. self.cfg.prefab_path
			local var_4_4 = GameObject.Instantiate((Asset.Load("CooperateUniqueSkillTimeline/" .. var_4_2 .. "/" .. self.cfg.prefab_path)))

			var_4_4:GetComponent(typeof(PooledAsset)):SetActive(true)
			table.insert(var_4_0, {
				obj = var_4_4,
				path = var_4_3
			})
		end

		local var_4_5 = self.heroIDList[1]

		if self.heroIDList[1] < 10000 then
			var_4_5 = var_4_5 * 100
		end

		self.callBack(var_4_0, var_4_5, self.cfg.prefab_path)
	end)
end

function HeroCooperationItemItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.data = arg_5_1
	self.cfg = ComboSkillCfg[arg_5_1]
	self.skillCfg = HeroSkillCfg[self.cfg.skill_id]
	self.callBack = arg_5_2
	self.selectHeroId = arg_5_3

	self:UpdateView()
end

function HeroCooperationItemItem:UpdateView()
	self.skillIcon_.sprite = getSpriteViaConfig("ComboSkill", self.cfg.skill_id)
	self.skillName_.text = GetI18NText(self.skillCfg.name)
	self.heroIDList = deepClone(self.cfg.cooperate_role_ids)

	CommonTools.UniversalSortEx(self.heroIDList, {
		map = function(arg_7_0)
			return arg_7_0
		end
	})

	for iter_6_0 = 1, 3 do
		SetActive(self[string.format("head%sGo_", iter_6_0)], false)
	end

	for iter_6_1, iter_6_2 in ipairs(self.heroIDList) do
		self.headControllerList[iter_6_1]:SetSelectedState(self.heroViewProxy_:GetHeroData(iter_6_2).unlock == 1 and "on" or "off")
		SetActive(self[string.format("head%sGo_", iter_6_1)], true)

		self[string.format("head%sIcon_", iter_6_1)].sprite = getSpriteViaConfig("HeroItemshead", self.heroViewProxy_:GetHeroUsingSkinInfo(iter_6_2).id)
	end
end

function HeroCooperationItemItem:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	HeroCooperationItemItem.super.Dispose(self)
end

return HeroCooperationItemItem

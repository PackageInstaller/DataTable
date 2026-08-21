-- chunkname: @IQIGame\\UI\\CommonTips\\SkillTipsContent\\SkillTipsContent.lua

local SkillTipsHeadContent = require("IQIGame.UI.CommonTips.SkillTipsContent.SkillTipsHeadContent")
local SkillTipsInfoContent = require("IQIGame.UI.CommonTips.SkillTipsContent.SkillTipsInfoContent")
local SkillTipsContent = {}

function SkillTipsContent.New(view)
	local obj = Clone(SkillTipsContent)

	obj:__Init(view)

	return obj
end

function SkillTipsContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.headContent = SkillTipsHeadContent.New(self.TopParent)
	self.infoContent = SkillTipsInfoContent.New(self.ContentScrollView)

	function self.__onDetailBtnClickEventProxy()
		self:__OnDetailBtnClickEventHandler()
	end

	self:__AddListeners()
end

function SkillTipsContent:__AddListeners()
	self.DetailBtn:GetComponent("Button").onClick:AddListener(self.__onDetailBtnClickEventProxy)
end

function SkillTipsContent:__RemoveListeners()
	self.DetailBtn:GetComponent("Button").onClick:RemoveListener(self.__onDetailBtnClickEventProxy)
end

function SkillTipsContent:Dispose()
	self:__RemoveListeners()
	self.headContent:Dispose()
	self.infoContent:Dispose()

	self.itemData = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkillTipsContent:SetData(userData)
	self.itemData = userData.data

	self.headContent:SetData(self.itemData, userData.cbParams)
	self.infoContent:SetData(self.itemData, userData.cbParams)
	self.DetailBtn:SetActive(not userData.cbParams.forShow)
	self:__RefreshWareState(self.itemData.skillData)
end

function SkillTipsContent:__RefreshWareState(skillData)
	local needShow = skillData.heroCid ~= 0 and skillData.id ~= 0

	LuaUtility.SetGameObjectShow(self.WareState, needShow)

	if not needShow then
		return
	end

	local headPath = SkinModule.GetHeroCurrentSkinImgPath(skillData.heroCid, Constant.SkinImageType.HeadIcon)

	AssetUtil.LoadImage(self, headPath, self.heroHeadIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.wareText, CfgHeroTable[skillData.heroCid].Name)
end

function SkillTipsContent:__OnDetailBtnClickEventHandler()
	UIModule.Close(Constant.UIControllerName.CommonSkillTipsUI)
	UIModule.Open(Constant.UIControllerName.DiySkillStrengthenUI, Constant.UILayer.UI, {
		tabIndex = 1,
		skillData = self.itemData.skillData
	})
end

return SkillTipsContent

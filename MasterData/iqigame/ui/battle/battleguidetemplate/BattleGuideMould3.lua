-- chunkname: @IQIGame\\UI\\Battle\\BattleGuideTemplate\\BattleGuideMould3.lua

local BattleGuideTemplateBase = require("IQIGame/UI/Battle/BattleGuideTemplate/BattleGuideTemplateBase")
local BattleGuideMould3 = Clone(BattleGuideTemplateBase)

function BattleGuideMould3:__Init()
	LuaCodeInterface.BindOutlet(self.view, self)
end

function BattleGuideMould3:__Show()
	local mouldCfg = CfgBattleGuideModuleTable[self.guideData.moduleId]
	local path = BattleUIApi:GetGuideUIImagePath(mouldCfg.ShowImage[1])

	AssetUtil.LoadImage(self, path, self.icon:GetComponent("Image"))

	self.content1:GetComponent("Text").text = mouldCfg.ShowText[1]
	self.content2:GetComponent("Text").text = mouldCfg.ShowText[2]
end

function BattleGuideMould3:__Hide()
	return
end

function BattleGuideMould3:__Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)
end

return BattleGuideMould3

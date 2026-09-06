-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/Babybuscodetipview.lua

module("logic.extensions.babybus.view.Babybuscodetipview", package.seeall)

local Babybuscodetipview = class("Babybuscodetipview", BirthdaytipsView)

function Babybuscodetipview:onEnter()
	BirthdaytipsView.super.onEnter(self)

	local str = self:getFirstParam()

	self.txtRules.text = langPara("亲爱的小奥奇，您的专属兑换码为：<color=#eb4642>%s</color>，可以前往《奥奇传说页游》兑换奖励！", str)

	local str = BabybusConfig.instance:getCommonVelue("SIGN_IN_TIPS_LIST")
	local list = string.split(str, "#")

	self.scrollList:reloadData(list)
end

function Babybuscodetipview:_updateCell(view, cell, data, tag)
	local pre = BabybusConfig.instance:getCommonVelue("SIGN_IN_TIPS_ICON_PRE")

	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("bonus", pre .. data))
end

return Babybuscodetipview

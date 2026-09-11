local NaviBar = class("NaviBar", ReduxView)
local TaskConst = import("game.const.TaskConst")
local ViewConst = import("game.const.ViewConst")
local JumpTools = import("game.tools.JumpTools")

function NaviBar:OnCtor()
	return
end

function NaviBar:UIName()
	return "UI/NaviBarUI"
end

function NaviBar:UIParent()
	return manager.ui.uiPop.transform
end

function NaviBar:InitUI()
	return
end

function NaviBar:AddUIListener()
	self:AddBtnListener("navibar/topbtn/btn_userinfo", nil, function()
		gameContext:ClearHistroy()
		OpenPageUntilLoaded("/userinfo", nil, ViewConst.SYSTEM_ID.BACK_HOUSE)
	end)
	self:AddBtnListener("navibar/topbtn/btn_document", nil, function()
		return
	end)
	self:AddBtnListener("navibar/topbtn/btn_close", nil, function()
		self:Back()
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_hero", nil, function()
		gameContext:ClearHistroy()
		JumpTools.GoToSystem("/herolist", nil, ViewConst.SYSTEM_ID.HERO)
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_mission", nil, function()
		gameContext:ClearHistroy()
		JumpTools.GoToSystem("/task", {
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_battle", nil, function()
		gameContext:ClearHistroy()
		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.MAIN
		})
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_shop", nil, function()
		gameContext:ClearHistroy()
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_mail", nil, function()
		return
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_lounge", nil, function()
		return
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_guild", nil, function()
		gameContext:ClearHistroy()
	end)
	self:AddBtnListener("navibar/buildingbtn/btn_search", nil, function()
		gameContext:ClearHistroy()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
	self:AddBtnListener("mask", nil, function()
		self:Back()
	end)
	self:AddBtnListenerScale("btn_return", nil, function()
		self:Back()
	end)
	self:AddBtnListenerScale("btn_last", nil, function()
		self:Go("/home")
	end)
end

function NaviBar:Init()
	self:InitUI()
	self:AddUIListener()
end

function NaviBar:Dispose()
	self:RemoveAllListeners()
	NaviBar.super.Dispose(self)
end

return NaviBar

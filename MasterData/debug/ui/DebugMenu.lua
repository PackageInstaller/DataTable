-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\UI\\DebugMenu.lua

local DebugConst = require("Debug/DebugConst")
local DebugButton = require("Debug/UI/DebugButton")
local DataVersion = ""
local MODULE_LIST = {
	"DebugGM",
	"HandsomeDebug",
	"DebugBattle",
	"DebugHero",
	"DebugDrag",
	"DebugStoryScript",
	"DebugItem",
	"DebugModuleTemplate",
	"DebugTools",
	"DebugAR",
	"DebugCreate",
	"DebugAutoTest",
	"DebugProgramTemp"
}
local strClassName = "DebugMenu"
local DebugMenu = Class(strClassName, UIControls.Window)

function DebugMenu:ctor()
	self:initUI()

	self.homeData = {
		name = "返回主菜单",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = Slot(self.onBackHome, self)
	}
end

function DebugMenu:initUI()
	self.panelButton = UIControls.Panel(self, "Panel")
	self.btnToggle = UIControls.Button(self, "BtnToggle", "Text")

	self.btnToggle:setText("调试工具" .. DataVersion)
	self.btnToggle:addEventClick(self.onMenuToggle)

	self.btns = {}

	if Framework.Tools.LuaToolkit.IsEditor() then
		local DebugGM = require("Debug/Modules/DebugGM")

		if not IsGLDeclared("DebugModule") then
			GLDeclare("DebugModule", DebugGM)
		end
	end
end

function DebugMenu:setMenu(menuData)
	self.menuData = menuData

	local idx = 1
	local length = #menuData

	for i, btn in ipairs(self.btns) do
		btn:setting(menuData[idx])

		idx = idx + 1
	end

	for i = idx, length do
		local newBtn = DebugButton(self, "Panel", "Debug/DebugButton")

		newBtn:setting(menuData[i])
		table.insert(self.btns, newBtn)
	end
end

function DebugMenu:onMenuToggle()
	local preVisible = self.btnVisible

	self.btnVisible = not self.btnVisible

	if preVisible == nil then
		self:setMenu(DebugMenu.menu)
	else
		self.panelButton:setVisible(self.btnVisible)
	end
end

function DebugMenu:onBackHome(sender)
	self:setMenu(DebugMenu.menu)
end

function DebugMenu:setServerReplayValue(REPLAY_INFO)
	local names = {
		"无"
	}

	for i, value in ipairs(REPLAY_INFO) do
		table.insert(names, value)
	end

	for index, btn in pairs(self.btns) do
		if btn.data and btn.data.name == "玩家战斗回放列表" then
			btn.data.value = names

			btn.dropSelect:setItems(names)
		end
	end
end

DebugMenu.menu = {}

for i, moduleName in ipairs(MODULE_LIST) do
	local m = loadstring(string.format("return require 'Debug/Modules/%s'", moduleName))()

	if m then
		table.insert(DebugMenu.menu, {
			name = m.ENTRY_NAME,
			typ = DebugConst.BTN_TYPE_MENU,
			value = m.FUNC_MENU
		})
	end
end

table.insert(DebugMenu.menu, {
	name = "重置游戏",
	typ = DebugConst.BTN_TYPE_BUTTON,
	func = Game.Reload
})

return DebugMenu

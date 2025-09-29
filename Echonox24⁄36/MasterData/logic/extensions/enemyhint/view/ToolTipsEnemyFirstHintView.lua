-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/enemyhint/view/ToolTipsEnemyFirstHintView.lua

module("logic.extensions.enemyhint.view.ToolTipsEnemyFirstHintView", package.seeall)

local M = class("ToolTipsEnemyFirstHintView", ViewComponent)

function M:buildUI()
	self._panelGo = {
		self:getGo("enemy_first_appearance_tips_998167763"),
		self:getGo("enemy_first_appearance_tips_664838719")
	}
	self._clickBtn = self:getBtn("2&empty_mask_tips_29887572")
	self._enemy = {}

	for i = 1, 2 do
		local panel = {}

		panel.img = goutil.findChildImageComponent(self._panelGo[i], "Image0/imgEnemy")
		panel.hint = goutil.findChildTextComponent(self._panelGo[i], "txtlHint/txtDesc")
		panel.careerDi = goutil.findChildImageComponent(self._panelGo[i], "career/type1/imgCareerDi")
		panel.careerSign = goutil.findChildImageComponent(self._panelGo[i], "career/type1/imgCareerSign")
		panel.txtName = goutil.findChildTextComponent(self._panelGo[i], "txtName")
		panel.txtDesc = goutil.findChildTextComponent(self._panelGo[i], "txtDesc")
		panel.txtLabel1 = goutil.findChildTextComponent(self._panelGo[i], "txtDescribe1")
		panel.txtLv1 = goutil.findChildTextComponent(self._panelGo[i], "txtLevel1")
		panel.txtLabel2 = goutil.findChildTextComponent(self._panelGo[i], "txtDescribe2")
		panel.txtLv2 = goutil.findChildTextComponent(self._panelGo[i], "txtLevel2")

		table.insert(self._enemy, panel)
	end
end

function M:onDestroy()
	self._enemy = {}
end

function M:bindEvents()
	self._clickBtn:AddClickListener(self._clickMask, self)
end

function M:unbindEvents()
	self._clickBtn:RemoveClickListener()
end

function M:onEnter()
	local openParams = self:getOpenParam()
	local code = openParams[1]

	self._callbackFunc = openParams[2]
	self._callbackObj = openParams[3]
	self._enemyConf = SystemOpenConfig.instance:getMonsterHintByCode(code)

	goutil.setActive(self._panelGo[1], self._enemyConf.isBoss == 1)
	goutil.setActive(self._panelGo[2], self._enemyConf.isBoss ~= 1)
	self:updateInfo()
end

function M:updateInfo()
	local panel = self._enemy[2 - self._enemyConf.isBoss]

	if not panel then
		return
	end

	panel.txtName.text = self._enemyConf.name
	panel.hint.text = self._enemyConf.hint
	panel.txtDesc.text = self._enemyConf.funcDesc

	IconLoader.setSprite(panel.careerDi, IconType.Skinlib, CommEnum.ColorType2Icon[self._enemyConf.colorType])
	IconLoader.setSprite(panel.careerSign, IconType.Skinlib, CommEnum.Career2Icon[self._enemyConf.career])

	local param = string.split(self._enemyConf.label, ";")

	panel.txtLabel1.text = param[1]
	panel.txtLv1.text = param[2]
	panel.txtLabel2.text = param[3]
	panel.txtLv2.text = param[4]
end

function M:_clickMask()
	self:close()

	if self._callbackFunc then
		self._callbackFunc(self._callbackObj)
	end
end

return M

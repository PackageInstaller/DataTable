-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/WelfareTipsView.lua

module("logic.extensions.welfare.view.WelfareTipsView", package.seeall)

local M = class("WelfareTipsView", ViewComponent)

function M:buildUI()
	self.btn_btnClose = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self.go_detailItem = self:getGo("activity_detail_tips_534768714")
	self.tr_parent = self:getRectTransform("activity_detail_tips_710451007")
end

function M:bindEvents()
	self.btn_btnClose:AddClickListener(self._onClickBack, self)
end

function M:unbindEvents()
	self.btn_btnClose:RemoveClickListener()
end

function M:onEnter()
	local input = self:getFirstParam()

	if string.nilorempty(input) then
		return
	end

	Astral.TransformUtil.SetAnchoredPos(self.tr_parent, 0, 0)
	self:_updatePanel(input)
end

function M:onExit()
	return
end

function M:_updatePanel(input)
	local titleList, contentList = StringUtil.splitTitleAndContent(input)

	if not titleList or not contentList then
		return
	end

	local itemCount = math.max(#titleList, #contentList)
	local roleChildCount = self.tr_parent.childCount

	if roleChildCount < itemCount then
		for i = roleChildCount + 1, itemCount do
			goutil.cloneAndSetParent(self.go_detailItem, self.tr_parent)
		end
	end

	for i = 1, self.tr_parent.childCount do
		local child = self.tr_parent:GetChild(i - 1)

		if i <= itemCount then
			goutil.setActive(child.gameObject, true)
			self:_updateTextItem(child.gameObject, titleList[i], contentList[i])
		else
			goutil.setActive(child.gameObject, false)
		end
	end
end

function M:_updateTextItem(itemGo, title, content)
	local txt_title = goutil.findChildTextComponent(itemGo, "imgTitle/txtTitle")
	local txt_content = goutil.findChildTextComponent(itemGo, "txtContent")

	if txt_title then
		txt_title.text = title
	end

	if txt_content then
		txt_content.text = content
	end
end

function M:_onClickBack()
	self:close()
end

return M

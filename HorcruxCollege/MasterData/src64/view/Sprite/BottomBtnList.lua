BottomBtnList = class("BottomBtnList", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = "public/panelbg/under_bottom.png"
local var_0_2 = {
	"public/button/bottom_return_btn.png",
	"public/button/return_bntWord.png"
}
local var_0_3 = "public/button/public_button_normal_y.png"
local var_0_4 = 540
local var_0_5 = 200

function BottomBtnList.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = BottomBtnList.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function BottomBtnList:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:setContentSize(640, 62)

	if arg_3_4 and arg_3_4.isMainScenebg then
		self:setBackGroundImage(arg_3_3 or var_0_1)
	else
		self:setBackGroundImage(arg_3_3 or var_0_1, var_0_0)
	end

	self:setTouchEnabled(true)
	self:initReturnBtn(arg_3_1, arg_3_4)
	self:initBtnList(arg_3_2)
end

function BottomBtnList:initReturnBtn(arg_4_1, arg_4_2)
	local var_4_0
	local var_4_1

	if arg_4_2 then
		var_4_0 = arg_4_2.img or var_0_2[1]
		var_4_1 = arg_4_2.pos or cc.p(62, 58)
	else
		var_4_0 = var_0_2[1]
		var_4_1 = cc.p(62, 58)
	end

	local var_4_2 = arg_4_2 and arg_4_2.isMainScenebg and ccui.Button:create(var_4_0, nil, var_4_0) or ccui.Button:create(var_4_0, nil, var_4_0, var_0_0)

	var_4_2:setPosition(var_4_1)
	var_4_2:setName("returnBtn")
	self:addChild(var_4_2)
	var_4_2:addTouchEventListener(arg_4_1)
end

function BottomBtnList:initBtnList(arg_5_1)
	if not arg_5_1 then
		return
	end

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_0 = arg_5_1[iter_5_0].texture or var_0_3
		local var_5_1 = ccui.Button:create(var_5_0, nil, var_5_0, var_0_0)

		var_5_1:setName(arg_5_1[iter_5_0].name)

		local var_5_2 = cc.Label:createWithTTF(arg_5_1[iter_5_0].word or "", "fonts/newkj.ttf", 30)

		var_5_2:setPosition(cc.p(var_5_1:getContentSize().width / 2, var_5_1:getContentSize().height / 2))
		var_5_2:setColor(cc.c3b(55, 55, 63))
		var_5_2:setName("word")
		var_5_1:addChild(var_5_2)
		var_5_1:setPosition(cc.p(var_0_4 - var_0_5 * (iter_5_0 - 1), 30))
		self:addChild(var_5_1)
		var_5_1:addTouchEventListener(arg_5_1[iter_5_0].handler)
	end
end

function BottomBtnList:getBtn(arg_6_1)
	return self:getChildByName(arg_6_1)
end

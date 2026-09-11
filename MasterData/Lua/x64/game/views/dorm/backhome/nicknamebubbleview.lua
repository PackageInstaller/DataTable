local NickNameBubbleView = class("NickNameBubbleView", import("game.extend.BaseView"))

function NickNameBubbleView:UIName()
	return "Widget/BackHouseUI/Dorm/item/NicknameBubbleView"
end

function NickNameBubbleView:Ctor(arg_2_1)
	NickNameBubbleView.super.Ctor(self)

	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiMain.transform)
	self.needDisposeGo = true
	self.transform_ = nullable(self.gameObject_, "transform")

	self.transform_:SetAsFirstSibling()

	self.nicknameBubbles = {}

	self:BindCfgUI()
end

function NickNameBubbleView:OnEnter()
	self:OnEnable()
end

function NickNameBubbleView:OnEnable()
	self:RegistEventListener(DORM_CHARACTER_DISPOSE, handler(self, self.OnEntityDispose))
	self:RegistEventListener(DORM_VISIT_CHARACTER_NICKNAME, handler(self, self.OnPlayVisitNickName))
	DormHeroTools:ShowVisitName()
end

function NickNameBubbleView:OnExit()
	self:OnDisable()
end

function NickNameBubbleView:OnDisable()
	for iter_6_0, iter_6_1 in pairs(self.nicknameBubbles) do
		iter_6_1:Dispose()
	end

	self.nicknameBubbles = {}

	self:RemoveAllEventListener()
end

function NickNameBubbleView:Dispose()
	GameObject.Destroy(self.gameObject_)
end

function NickNameBubbleView:GetVisitBubble(arg_8_1)
	local var_8_0 = self.nicknameBubbles[arg_8_1]

	if not self.nicknameBubbles[arg_8_1] then
		local var_8_1 = GameObject.Instantiate(self.visitNamePrefab, self.bubbleRoot)

		var_8_0 = NicknameBubbleItem.New(var_8_1)

		var_8_0.content:SetActive(false)

		self.nicknameBubbles[arg_8_1] = var_8_0

		var_8_1:SetActive(true)
	end

	return var_8_0
end

function NickNameBubbleView:OnPlayVisitNickName(arg_9_1, arg_9_2)
	if DormHeroTools:CheckIsVisitHero(arg_9_1) then
		local var_9_0 = self:GetVisitBubble(arg_9_1)

		if var_9_0 == nil then
			return
		end

		DormLuaBridge.SetUIFollow(var_9_0.transform_, arg_9_1, "gua_Hp")
		var_9_0:ShowSubtitle(arg_9_1)
		var_9_0:SetData(arg_9_2)
	end
end

function NickNameBubbleView:OnEntityDispose(arg_10_1)
	if self.nicknameBubbles[arg_10_1] then
		self.nicknameBubbles[arg_10_1]:Dispose()

		self.nicknameBubbles[arg_10_1] = nil
	end
end

return NickNameBubbleView

local HellaPinballRankItem = class("HellaPinballRankItem", BaseView)

function HellaPinballRankItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HellaPinballRankItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListeners()

	self.rankController = self.conExCollection_:GetController("rank")
	self.viewController = self.conExCollection_:GetController("viewBtn")
end

function HellaPinballRankItem:AddUIListeners()
	return
end

function HellaPinballRankItem:Dispose()
	self.commonPortrait:Dispose()
	HellaPinballRankItem.super.Dispose(self)
end

function HellaPinballRankItem:GetRankActivityID()
	return 3840901
end

function HellaPinballRankItem:SetData(arg_6_1)
	self.data = arg_6_1
	self.rankText_.text = GetI18NText(arg_6_1.rank)
	self.scoreText_.text = GetI18NText(arg_6_1.score)

	if arg_6_1.rank <= 3 then
		self.rankController:SetSelectedIndex(arg_6_1.rank)
	else
		self.rankController:SetSelectedIndex(0)
	end

	self.nickText_.text = GetI18NText(arg_6_1.nick)

	self.commonPortrait:RenderHead(arg_6_1.portrait)
	self.commonPortrait:RenderFrame(arg_6_1.frame)

	if #arg_6_1.extraInfo > 0 then
		self.viewController:SetSelectedState("normal")

		for iter_6_0 = 1, 2 do
			if arg_6_1.extraInfo[iter_6_0] then
				SetActive(self["skillItem" .. iter_6_0 .. "_"], true)

				self["skillItemIcon" .. iter_6_0 .. "_"].sprite = pureGetSpriteWithoutAtlas(PinballSkillCfg[arg_6_1.extraInfo[iter_6_0]].icon)
			else
				SetActive(self["skillItem" .. iter_6_0 .. "_"], false)
			end
		end
	else
		self.viewController:SetSelectedState("lock")
	end
end

return HellaPinballRankItem

local CoreVerificationTeamInfoItem = class("CoreVerificationTeamInfoItem", ReduxView)

function CoreVerificationTeamInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	self.heroHeadItem_ = {}
end

function CoreVerificationTeamInfoItem:Init()
	self:InitUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CoreVerificationTeamInfoHeadIconItem)
end

function CoreVerificationTeamInfoItem:InitUI()
	self:BindCfgUI()
end

function CoreVerificationTeamInfoItem:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.list[arg_4_1])
end

function CoreVerificationTeamInfoItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		return
	end)
end

function CoreVerificationTeamInfoItem:SetData(arg_7_1, arg_7_2)
	self.data = arg_7_1
	self.nameText_.text = GetTips("CORE_VERIFICATION_BOSS_DES_" .. arg_7_2)

	if self.data and self.data.score ~= 0 then
		self.list = self.data.hero_list or {}

		self.list_:StartScroll(#self.list)

		self.scoreText_.text = self.data.score
	else
		self.list_:StartScroll(0)

		self.scoreText_.text = 0
	end
end

function CoreVerificationTeamInfoItem:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	CoreVerificationTeamInfoItem.super.Dispose(self)
end

return CoreVerificationTeamInfoItem

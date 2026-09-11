local DormInfomationTabModule = class("DormInfomationTabModule", ReduxView)

function DormInfomationTabModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	arg_1_1:SetActive(true)
	self:InitUI()
end

function DormInfomationTabModule:InitUI()
	self.callback = nil
	self.txt1 = self.transform_:Find("upselect/Textupselect01").gameObject:GetComponent(typeof(Text))
	self.txt2 = self.transform_:Find("select_on/Textselect01").gameObject:GetComponent(typeof(Text))

	self:AddListener()
end

function DormInfomationTabModule:AddListener()
	self:AddToggleListener(self.gameObject_:GetComponent(typeof(Toggle)), function(arg_4_0)
		if arg_4_0 and self.callback then
			self.callback(self.id)
		end
	end)
end

function DormInfomationTabModule:BindId(arg_5_1)
	self.id = arg_5_1
	self.txt1.text = BackhomeContentNoticeCfg[arg_5_1].title
	self.txt2.text = BackhomeContentNoticeCfg[arg_5_1].title
end

function DormInfomationTabModule:RegisterClickCallback(arg_6_1)
	self.callback = arg_6_1
end

function DormInfomationTabModule:Dispose()
	if not isNil(self.gameObject_) then
		GameObject.Destroy(self.gameObject_)
	end

	DormInfomationTabModule.super.Dispose(self)
end

return DormInfomationTabModule

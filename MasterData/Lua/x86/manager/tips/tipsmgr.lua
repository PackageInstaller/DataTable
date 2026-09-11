local TipsLongView = import("manager.tips.TipsLongView")
local TipsMgr = class("TipsMgr")

function TipsMgr:Ctor()
	self.gameObject_ = nil
end

function TipsMgr:OnCtor()
	print("initializing tip manager...")
end

function TipsMgr:InitUI()
	self.gameObject_ = GameObject.Instantiate(Asset.Load("UI/TipPanel"), GameObject.Find("UICamera_DontDestroy/Canvas/UITip").transform)
	self.transform_ = self.gameObject_.transform
	self.longTips_ = TipsLongView.New(self.gameObject_)
end

function TipsMgr:ShowTips(arg_4_1, arg_4_2, arg_4_3)
	if self.gameObject_ == nil then
		self:InitUI()
	end

	if TipsCfg[arg_4_2] then
		self.longTips_:ShowTips(arg_4_1)
		manager.audio:PlayEffect("ui_system", TipsCfg[arg_4_2].audio, "")
	else
		self.longTips_:ShowTips(arg_4_1)
		manager.audio:PlayEffect("ui_system", "success", "")
	end
end

function TipsMgr:Show(arg_5_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_5_1)
	end
end

function TipsMgr:Dispose()
	if self.longTips_ then
		self.longTips_:Dispose()

		self.longTips_ = nil
	end

	if self.gameObject_ then
		Object.Destroy(self.gameObject_)

		self.transform_ = nil
		self.gameObject_ = nil
	end
end

return TipsMgr

local EntityBubbleBase = class("EntityBubbleBase", BaseView)

function EntityBubbleBase:UIName()
	return nil
end

function EntityBubbleBase:Ctor(...)
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiMain.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.follow = self.transform_:GetComponent("UIFollow")

	self:InitUI()
	self:RegisterEvents()
	self:SetData(...)
end

function EntityBubbleBase:InitUI()
	return
end

function EntityBubbleBase:RegisterEvents()
	return
end

function EntityBubbleBase:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	GameObject.Destroy(self.gameObject_)
	EntityBubbleBase.super.Dispose(self)
end

function EntityBubbleBase:SetData()
	return
end

function EntityBubbleBase:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function EntityBubbleBase:SetFollowEntity(arg_8_1, arg_8_2)
	DormLuaBridge.SetUIFollow(self.transform_, arg_8_1, arg_8_2)
end

function EntityBubbleBase:SetFollowTransform(arg_9_1)
	self.follow.origin = arg_9_1
end

return EntityBubbleBase

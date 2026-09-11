local AshILLWeaponPage = class("AshILLWeaponPage", ReduxView)

function AshILLWeaponPage:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.canvasGroup = arg_1_1:GetComponent(typeof(CanvasGroup))
	self.weaponConatiner = self.transform_:Find("Viewport/WeaponList")

	self:Init()
end

function AshILLWeaponPage:Init()
	self.modules = {}

	for iter_2_0, iter_2_1 in ipairs((AshSystemData:GetWeaponList())) do
		table.insert(self.modules, AshILLWeaponModule.New(self.weaponConatiner, nil, "WEAPON"))
	end
end

function AshILLWeaponPage:EnterPanel(arg_3_1)
	self.canvasGroup.alpha = 1
	self.canvasGroup.blocksRaycasts = true

	for iter_3_0, iter_3_1 in ipairs((AshSystemData:GetWeaponList())) do
		self.modules[iter_3_0]:Render(iter_3_1)
	end
end

function AshILLWeaponPage:ExitPanel(arg_4_1)
	self.canvasGroup.alpha = 0
	self.canvasGroup.blocksRaycasts = false
end

function AshILLWeaponPage:Render()
	return
end

function AshILLWeaponPage:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.modules) do
		iter_6_1:Dispose()
	end

	self.modules = nil

	self.super.Dispose(self)
end

return AshILLWeaponPage

pg = pg or {}
pg.ClickEffectMgr = singletonClass("ClickEffectMgr")
pg.ClickEffectMgr.CONFIG = {
	NORMAL = {
		"ui",
		"clickeffect"
	},
	DORM3D = {
		"ui",
		"clickeffectdorm"
	}
}

function pg.ClickEffectMgr:Init(arg_1_1)
	print("initializing click effect manager...")

	self.OverlayCamera = tf(GameObject.Find("OverlayCamera"))
	self.OverlayEffect = self.OverlayCamera:Find("Overlay/UIEffect")
	self.OverlayEffectClickCom = self.OverlayEffect:GetComponent("ClickEffectBehaviour")

	self.OverlayEffectClickCom:Init(self.OverlayCamera:GetComponent("Camera"), self.OverlayEffect)

	self.effectClick = nil
	self.effectDic = {}

	SetActive(self.OverlayEffect, PlayerPrefs.GetInt(SHOW_TOUCH_EFFECT, 1) > 0)
	self:SetClickEffect("NORMAL", nil, nil, arg_1_1)

	return
end

function pg.ClickEffectMgr:ClearClickEffect()
	if self.clickEffect then
		self.OverlayEffectClickCom:UnRegisterEffect()
		SetActive(self.clickEffect, false)

		self.clickEffect = nil
	end

	return
end

function pg.ClickEffectMgr:SetClickEffect(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not self.CONFIG[arg_3_1] then
		return
	end

	local var_3_0 = self.CONFIG[arg_3_1][1]
	local var_3_1 = self.CONFIG[arg_3_1][2]

	self:ClearClickEffect()

	self.clickEffect = self.effectDic[self.CONFIG[arg_3_1][2]]

	local function var_3_2()
		self.OverlayEffectClickCom:RegisterEffect(self.clickEffect, arg_3_2, arg_3_3)

		if arg_3_4 then
			arg_3_4()
		end

		return
	end

	if self.clickEffect then
		var_3_2()
	else
		LoadAndInstantiateAsync(var_3_0, self.CONFIG[arg_3_1][2], function(arg_5_0)
			self.effectDic[var_3_1] = go(arg_5_0)

			setParent(self.effectDic[var_3_1], self.OverlayEffect)

			self.clickEffect = self.effectDic[var_3_1]

			var_3_2()

			return
		end)
	end

	return
end

return

local var_0_0 = g.core.const.ConstMgr.AncientsConst
local AncientsReviewLayer = class("AncientsReviewLayer", require("app.fairyGUI.ancients.UI_AncientsReviewLayer"), function()
	return fgui.GComponent:create({
		resName = "AncientsReviewLayer",
		pkgPath = "ui/ancients/ancients",
		isFullScreen = true,
		pkgName = "ancients"
	}, ...)
end)

function AncientsReviewLayer:ctor()
	self:addBg("bg/ancients/bg_jxmy_dfs.jpg")
	self.m_topBarComp:setResInfoById(var_0_0.TopBarId)
end

function AncientsReviewLayer:onLoad()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS)
	g.core.network.GameNetProxy:send_C2S_Ancient_Enter({})
end

return AncientsReviewLayer

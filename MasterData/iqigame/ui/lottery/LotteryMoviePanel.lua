-- chunkname: @IQIGame\\UI\\Lottery\\LotteryMoviePanel.lua

local LotteryMoviePanel = {}

function LotteryMoviePanel.New(go, mainView)
	local o = Clone(LotteryMoviePanel)

	o:Initialize(go, mainView)

	return o
end

function LotteryMoviePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
	self:Refresh()
end

function LotteryMoviePanel:InitComponent()
	self.buttonSkip = self.buttonSkip:GetComponent("Button")
end

function LotteryMoviePanel:InitDelegate()
	function self.buttonSkipDelegate()
		self:OnButtonSkipClick()
	end
end

function LotteryMoviePanel:AddListener()
	self.buttonSkip.onClick:AddListener(self.buttonSkipDelegate)
end

function LotteryMoviePanel:RemoveListener()
	self.buttonSkip.onClick:RemoveListener(self.buttonSkipDelegate)
end

function LotteryMoviePanel:OnButtonSkipClick()
	if self.currentMovieEndCallBack then
		self:currentMovieEndCallBack()
	end
end

function LotteryMoviePanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function LotteryMoviePanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function LotteryMoviePanel:Refresh()
	LuaUtility.SetGameObjectShow(self.specialMovie, false)
	LuaUtility.SetGameObjectShow(self.normalMovie, false)
end

function LotteryMoviePanel:PlayMovie(movieType, onCompleteCallBack)
	self:Refresh()

	if movieType == Constant.LotteryMovieType.SSR then
		LuaUtility.SetGameObjectShow(self.specialMovie, true)

		self.currentMovie = self.specialMovie

		function self.currentMovieEndCallBack()
			LuaUtility.SetGameObjectShow(self.specialMovie, false)

			self.currentMovieEndCallBack = nil

			self:Close()

			if onCompleteCallBack then
				onCompleteCallBack()
			end
		end

		LuaUtility.SetCriWarEndCallBack(self.specialMovie, self.currentMovieEndCallBack)
	elseif movieType == Constant.LotteryMovieType.Normal then
		LuaUtility.SetGameObjectShow(self.normalMovie, true)

		self.currentMovie = self.normalMovie

		function self.currentMovieEndCallBack()
			LuaUtility.SetGameObjectShow(self.normalMovie, false)

			self.currentMovieEndCallBack = nil

			self:Close()

			if onCompleteCallBack then
				onCompleteCallBack()
			end
		end

		LuaUtility.SetCriWarEndCallBack(self.normalMovie, self.currentMovieEndCallBack)
	end
end

return LotteryMoviePanel

local VoteAwardPtWindow = class("VoteAwardPtWindow", import("view.activity.Panels.PtAwardWindow"))

VoteAwardPtWindow.TYPE_CURR = 1
VoteAwardPtWindow.TYPE_ACC = 2

function VoteAwardPtWindow:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self.binder = arg_1_2
	self.scrollPanel = self._tf:Find("frame/panel")
	self.UIlist = UIItemList.New(self._tf:Find("frame/panel/list"), self._tf:Find("frame/panel/list/tpl"))
	self.ptTF = self._tf:Find("frame/pt")
	self.totalTxt = self._tf:Find("frame/pt/Text"):GetComponent(typeof(Text))
	self.totalTitleTxt = self._tf:Find("frame/pt/title"):GetComponent(typeof(Text))

	return
end

function VoteAwardPtWindow:UpdateTitle(arg_2_1)
	if arg_2_1 == VoteAwardPtWindow.TYPE_CURR then
		self.resTitle, self.cntTitle = i18n("vote_lable_curr_title_1"), i18n("vote_lable_curr_title_2")
	elseif arg_2_1 == VoteAwardPtWindow.TYPE_ACC then
		self.resTitle, self.cntTitle = i18n("vote_lable_acc_title_1"), i18n("vote_lable_acc_title_2")
	end

	return
end

function VoteAwardPtWindow:updateResIcon()
	return
end

return VoteAwardPtWindow

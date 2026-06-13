local M = BaseClass("OpenNoticePopup",BaseJumpCommand)

function M:Execute()
    UIContextMgr:GetInstance():Show("NoticePopup",Bind(self,self._OnClosePopup))
end

function M:_OnClosePopup()
    CommandMgr:GetInstance():FinishExcute()
end

return M 
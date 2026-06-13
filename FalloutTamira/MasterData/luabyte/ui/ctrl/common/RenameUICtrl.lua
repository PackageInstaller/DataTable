--改名模块为基类
--勿要修改此脚本代码
--使用方法参考CdkRenameUICtrl

local RenameUICtrl = BaseClass("RenameUICtrl", BaseUICtrl)
local M = RenameUICtrl

function M:__init()
    self._view.rectComfirm:onClick(Bind(self, self.OnClickConfirm))
    self._view.rectCancel:onClick(Bind(self, self.Close))
    self._view.rectClose:onClick(Bind(self, self.Close))
end

--初始化(可重写)
function M:Init()
end

--设置标题(可调用)
function M:SetTitle(titleLangId)
    if titleLangId and titleLangId > 0 then
        self._view.txtTitleCN:SetText(titleLangId)
    end
end

--设置默认内容 (可调用)
function M:SetContentDefault(holdLangId, inputContentLangId)
    if holdLangId then
        self._view.txtPlaceholder:SetText(holdLangId)
    end
    if inputContentLangId then
        self._view.inputContent:SetText(inputContentLangId)
    end
end

function M:SetCharacterLimit(systemId)
    local limitNum = ConfigHelper.GetSystemParam(systemId)
    self._view.inputContent:SetCharacterLimit(limitNum)
end

function M:SetContentType(type)
    self._view.inputContent:SetContentType(type)
end


function M:OnClickConfirm()
    local inputStr = self._view.inputContent:GetText()
 
    if inputStr == nil or inputStr == "" then
        GameHelper.TipsById(12)
        return
    end
    inputStr = string.gsub(inputStr,"%s%p%c\r\n","")
    self:OnConfirmInput(inputStr)
    self:Close()
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return RenameUICtrl
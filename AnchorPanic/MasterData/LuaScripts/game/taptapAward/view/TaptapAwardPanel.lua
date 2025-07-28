module("taptapAward.TaptapAwardPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("taptapAward/TaptapAwardPanel.prefab")


panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function initData(self)
end


-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnJump = self:getChildGO("mBtnJump")
    self.mBtnClose = self:getChildGO("mBtnClose")
end

function active(self,args)
    super.active(self,args)
    if args then
        self.finishCall = args.finishCall
    end
    GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, { moduleId = RemindConst.TAPTAP_AWARD })
end

function deActive(self)
    super.deActive(self)
    if self.finishCall then
        self.finishCall()
        self.finishCall = nil
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnJump, self.onBtnFightClickHandler)
    self:addUIEvent(self.mBtnClose, self.onBtnCloseClickHandler)
end

function onBtnFightClickHandler(self)
    local url = "https://www.taptap.cn/app/207018"
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.WebView, param = { webUrl = url} })
end

function onBtnCloseClickHandler(self)
    self:close()
end

return _M
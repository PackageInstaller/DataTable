module("taptapAward.TaptapAwardPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("taptapAward/TaptapAwardPanel.prefab")


panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function initData(self)
end


-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnJump = self:getChildGO("mBtnJump")
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mTxtRemaid = self:getChildGO("mTxtRemaid"):GetComponent(ty.Text)
    self.mToggleRemaid = self:getChildGO("mToggleRemaid"):GetComponent(ty.Toggle)

    --self.mBtnClose:SetActive(false)
    gs.TransQuick:UIPos(self.mBtnClose:GetComponent(ty.RectTransform), 539.5,232.2)
end

function initViewText(self)
    self.mTxtRemaid.text = _TT(1430)
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
    
    if self.mToggleRemaid.isOn then
        local prefixVersion =
        download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
        if not StorageUtil:getBool1(prefixVersion .. "taptapNotShow") then
            StorageUtil:saveBool1(prefixVersion .. "taptapNotShow", true)
            --GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
        end
    end

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
    local url = "https://l.taptap.cn/pLauEiwE?channel=rep-rep_w9x8nxhit8g"
    sdk.SdkManager:jumpBrowserWebView(url)
end

function onBtnCloseClickHandler(self)
    self:close()
end

return _M
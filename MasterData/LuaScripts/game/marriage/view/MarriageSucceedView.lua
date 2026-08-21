module("marriage.MarriageSucceedView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("marriage/MarriageSucceedView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mPropsItemList = {}
end

function configUI(self)
    self.mBtnClose = self:getChildGO("ImgMask")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)

    self.mTxtLvCur = self:getChildGO("mTxtLvCur"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)

    self.mPropsContent = self:getChildTrans("mPropsContent")
end

function initViewText(self)
    self.mTxtTitle.text = _TT(152019)
    self.mTxtAward.text = _TT(152014)
    self.mTxtLvCur.text = sysParam.SysParamManager:getValue(SysParamType.MAX_FAVORABLE_LV)
    self.mTxtLv.text = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_MAX_LV)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, function ()
        self:close()
        GameDispatcher:dispatchEvent(EventName.OPEN_MARRIAGE_RENAME_VIEW, {heroId = marriage.MarriageManager:getMarriageHeroId()})
    end)
end

function active(self, args)
    super.active(self)

    local awardList = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_AWARD_LIST)
    self:closePropsList()
    for i = 1, #awardList, 1 do
        local vo = props.PropsManager:getTypePropsVoByTid(awardList[i][1])
        local count = awardList[i][2]

        local propsGrid = PropsGrid:createByData({
            tid = awardList[i][1],
            num = awardList[i][2],
            parent = self.mPropsContent,
            scale = 0.7,
            showUseInTip = true
        })
        table.insert(self.mPropsItemList, propsGrid)
    end
end

function closePropsList(self)
    if #self.mPropsItemList > 0 then
        for _, item in ipairs(self.mPropsItemList) do
            item:poolRecover()
            item = nil
        end
        self.mPropsItemList = {}
    end
end

function deActive(self)
    
    super.deActive(self)
    self:closePropsList()
end

return _M

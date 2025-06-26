module("buildBase.BuildBaseStateGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("buildBase/HeroStateGrid.prefab")

function __initData(self)
    super.__initData(self)
    self.isShowBar = true
end

function __updateCustomView(self)
    self:__updateBasicView()
end

-- 更新基础的信息显示
function __updateBasicView(self)
    if (self.m_isLoadFinish) then
        local imgHead = self.m_childGos["mImgHead"]:GetComponent(ty.AutoRefImage)
        local lazy = self.m_childGos["mImgLazy"]
        local busy = self.m_childGos["mImgBusy"]
        local bar = self.m_childGos["mBar_01"]
        local colorBar = self.m_childGos["mImgColorBar"]:GetComponent(ty.Image)
        local icon = self.m_childGos["mIconState"]:GetComponent(ty.AutoRefImage)
        local title = self.m_childGos["mTxtTitleState"]:GetComponent(ty.Text)
        imgHead:SetImg(UrlManager:getHeroHeadUrl(self:getData()))

        local heroMsgVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(self:getData())
        local heroSettleBuildVo = buildBase.BuildBaseManager:getBuildBasePosDataByPos(heroMsgVo.buildId)
        local upLimit = sysParam.SysParamManager:getValue(SysParamType.BUILD_BASE_STAMINA)
        local state = 1
        local txt = ""
        local url = ""
        -- local color = "ffffffff" 
        lazy:SetActive(false)
        busy:SetActive(false)
        if heroSettleBuildVo.buildType == buildBase.BuildBaseType.Dormitory then
            if heroMsgVo.stamina == upLimit then
                state = 1 -- 休息完毕
                txt = "休息完毕"
            else
                state = 2 --休息中
                txt = "休息中"
                busy:SetActive(true)
            end
            url = "buildBase/buildbase_icon04.png"
        else
            if heroMsgVo.stamina == 0 then
                if heroMsgVo.staminaTime - GameManager:getClientTime() > 0 then
                    state = 4 --工作中
                    url = "buildBase/buildbase_icon05.png"
                    txt = "工作中"
                    busy:SetActive(true)
                else
                    state = 3 --疲惫
                    url = "buildBase/buildbase_icon06.png"
                    txt = _TT(1390)
                    lazy:SetActive(true)
                end
            else
                state = 4 --工作中
                url = "buildBase/buildbase_icon05.png"
                txt = "工作中"
                busy:SetActive(true)
            end
        end
        self:updateBar()
        if heroMsgVo.staminaTime - GameManager:getClientTime() <= 0 then
            if heroMsgVo.stamina > 0 then
                bar:SetActive(false)
                busy:SetActive(false)

            else
                bar:SetActive(true)
                busy:SetActive(true)
            end
        else
            bar:SetActive(true)
            busy:SetActive(true)
        end

        icon:SetImg(UrlManager:getPackPath(url))
        title.text = txt

        local percent = heroMsgVo.stamina / upLimit
        local color = "45cea2ff"
        if heroMsgVo.stamina <= sysParam.SysParamManager:getValue(SysParamType.STAMINALOW) then
            color = "d53529ff"
        elseif heroMsgVo.stamina < sysParam.SysParamManager:getValue(SysParamType.STAMINAHIGHT) then
            color = "ff9e35ff"
        end
        colorBar.fillAmount = percent
        colorBar.color = gs.ColorUtil.GetColor(color)
   
    end
end

function updateBar(self)
    if self.m_isLoadFinish then
        self.m_childGos["mBar_01"]:SetActive(self.isShowBar)
        self.m_childGos["mImgColorBar"]:SetActive(self.isShowBar)
    end
end

function __updateParent(self)
    super.__updateParent(self)
    if (self.m_isLoadFinish) then
        if (self.m_parentTrans ~= nil) then

        end
    end
end

function setBarShow(self, isShow)
    self.isShowBar = isShow
    self:updateBar()
end

function poolRecover(self)
    super.poolRecover(self)
    self.isShowBar = true
end

return _M
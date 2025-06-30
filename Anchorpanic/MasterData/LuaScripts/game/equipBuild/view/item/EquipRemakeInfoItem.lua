--[[ 
-----------------------------------------------------
@filename       : ***
@Description    : ***
@date           : ***
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module('game.equipBuild.view.item.EquipRemakeInfoItem', Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("equipBuild/item/EquipRemakeInfoItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

-- 罗马数字
PropsEquipSubTypeStr = {"一", "二", "三", "四", "五", "六"}

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构  
function dtor(self)
end

function initData(self)
    self.isCanChangeHeight = false
    self.isShow = false
    -- 当前选择的改造部位
    self.m_curSelectPos = -1
end

-- 初始化
function configUI(self)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    -- self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mTxtRemake = self:getChildGO("mTxtRemake"):GetComponent(ty.Text)

    self.mGroupB = self:getChildGO("mGroupB")
    self.mBtnOpenB = self:getChildGO("mBtnOpenB")
    self.mBtnRemake = self:getChildGO("mBtnRemake")
    self.mGroupAttr = self:getChildGO("mGroupAttr")
    self.mTxtNoneBGo = self:getChildGO("mTxtNoneB")
    self.mTxtNoneB = self:getChildGO("mTxtNoneB"):GetComponent(ty.Text)
    self.mTxtTitleB = self:getChildGO("mTxtTitleB"):GetComponent(ty.Text)
    self.mTxtRoteB = self:getChildGO("mTxtRoteB"):GetComponent(ty.Text)
    -- self.mTxtRangeB = self:getChildGO("mTxtRangeB"):GetComponent(ty.Text)
    self.mTxtClickTips = self:getChildGO("mTxtClickTips"):GetComponent(ty.Text)
    -- self.mProgressBarB = self:getChildGO("mProgressBarB"):GetComponent(ty.ProgressBar)
    -- self.mProgressBarB:InitData(0)

    self.mImgColorType = self:getChildGO("mImgColorType"):GetComponent(ty.AutoRefImage)

    self.mBtnRemake = self:getChildGO("mBtnRemake")
    self.mBtnRemakeAgent = self:getChildGO("mBtnRemakeAgent")
    self.mTxtRemakeAgent = self:getChildGO("mTxtRemakeAgent"):GetComponent(ty.Text)

    self.mBtnNone = self:getChildGO("mBtnNone")
    -- self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    -- self.aa = self:getChildTrans("")
end

-- 激活
function active(self)
    super.active(self)
    self:initViewText()
    self:addOnClick(self.mBtnRemake, self.onRemake)
    self:addOnClick(self.mBtnNone, self.onRemake)
    self:addOnClick(self.mBtnRemakeAgent, self.onRemakeAgent)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mGroupB)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtClickTips.text = _TT(71435)
    self.mTxtNoneB.text = _TT(71436)
    self.mTxtRemakeAgent.text = _TT(71450)
end

function onRemake(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_REMAKE_UP_VIEW, {
        pos = self.m_curSelectPos,
        equipVo = self.m_equipVo
    })
end

function onRemakeAgent(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_REMAKE_TARGET_VIEW, {
        pos = self.m_curSelectPos,
        equipVo = self.m_equipVo
    })
end

function onShow(self)
    if (not self.isCanChangeHeight) then
        return
    end
    self:onShowContent(true)
end

function onHide(self)
    if (not self.isCanChangeHeight) then
        return
    end
    self:onShowContent(false)
end

function setData(self, cusPos, cusEquipVo, cusData)
    self.m_equipVo = cusEquipVo
    self.attrData = cusData
    self.m_curSelectPos = cusPos
    self.mTxtRemake.text = "改造" .. PropsEquipSubTypeStr[cusPos]
    -- self.mTxtNum.text = PropsEquipSubTypeStr[cusPos]

    if not self.attrData then
        self.isShow = false
        -- self.mImgBg:SetImg(UrlManager:getPackPath("equipBuild/equip_remake_6.png"))
        self.mGroupAttr:SetActive(false)
        -- self.mProgressBarB.gameObject:SetActive(false)
        -- self.mTxtRangeB.gameObject:SetActive(true)
        self.mTxtNoneBGo:SetActive(true)
        -- self.mImgColor:SetImg(UrlManager:getRemakeTypeUrl(0))
        self:updateView()
    else
        -- self.mImgBg:SetImg(UrlManager:getPackPath("equipBuild/equip_remake_2.png"))
        self.mGroupAttr:SetActive(true)
        -- self.mProgressBarB.gameObject:SetActive(true)
        -- self.mTxtRangeB.gameObject:SetActive(true)
        self.mTxtNoneBGo:SetActive(false)

        -- self.mImgColor.gameObject:SetActive(true)
        self:updateView()
    end

    if (not self.isCanChangeHeight) then
        self.mGroupB:SetActive(true)
        gs.TransQuick:SizeDelta(self.UITrans, self.UITrans.sizeDelta.x, self:getHeight())
    end
end

function updateView(self)
    -- local colorStr = ""
    local colorType = 0
    if self.attrData == nil then
        colorType = RemakeType.None
        -- self.mTxtRangeB.gameObject:SetActive(false)
    else
        local key = self.attrData.key
        local value = self.attrData.value
        local minValue = self.attrData.minValue
        local maxValue = self.attrData.maxValue

        -- if (value >= maxValue) then
        --     colorStr = ColorUtil.RED_NUM
        -- else
        --     colorStr = ColorUtil.BLUE_NUM
        -- end

        self.mTxtTitleB.text = AttConst.getName(key)
        self.mTxtRoteB.text = "+" .. AttConst.getValueStr(key, value)
        -- self.mProgressBarB:SetValue(value, maxValue, false)

        self:updateState()

        -- mImgColor

        local orValue = math.floor(maxValue * (sysParam.SysParamManager:getValue(1913) / 1000) + 0.5)
        local viValue = math.floor(maxValue * (sysParam.SysParamManager:getValue(1912) / 1000) + 0.5)
        local blValue = math.floor(maxValue * (sysParam.SysParamManager:getValue(1911) / 1000) + 0.5)

        if value >= orValue then
            colorType = RemakeType.ORANGE
        elseif value < orValue and value >= viValue then
            colorType = RemakeType.VIOLET
        elseif value < viValue and value >= blValue then
            colorType = RemakeType.BLUE
        else
            colorType = RemakeType.GREEN
        end

        -- local pro = value / maxValue

        -- if pro >= sysParam.SysParamManager:getValue(1913) / 1000 then
        --     colorType = RemakeType.ORANGE
        -- elseif pro < sysParam.SysParamManager:getValue(1913) / 1000 and pro >= sysParam.SysParamManager:getValue(1912) / 1000 then
        --     colorType = RemakeType.VIOLET
        -- elseif pro < sysParam.SysParamManager:getValue(1912) / 1000 and pro >= sysParam.SysParamManager:getValue(1911) / 1000 then
        --     colorType = RemakeType.BLUE
        -- else
        --     colorType = RemakeType.GREEN
        -- end

        self.mImgColorType:SetImg(UrlManager:getPackPath("chip/mozu_icon_0" .. (colorType + 4) .. ".png"))
        -- self.mTxtRangeB.text = string.format(HtmlUtil:color(_TT(4365 + colorType), ColorUtil:getPropColor(colorType)) .. "(%s-%s)", AttConst.getValueStr(key, minValue), AttConst.getValueStr(key, maxValue))
    end

    -- self.mImgColor.color =  gs.ColorUtil.GetColor(ColorUtil:getRemakeColor(colorType))

    -- self.mImgColor:SetImg(UrlManager:getRemakeTypeUrl(colorType))

end

function updateState(self)
    self.mGroupB:SetActive(self.isShow)

    if self.isShow then
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtRoteB.transform)
        -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtRangeB.transform)
    end
end

-- 切换内容
function onShowContent(self, value)
    self.isShow = value
    self:updateState()
    gs.TransQuick:SizeDelta(self.UITrans, self.UITrans.sizeDelta.x, self:getHeight())
    self:dispatchEvent(self.EVENT_CHANGE, {
        item = self,
        isShow = self.isShow
    })
end

-- 关闭内容
function closeContent(self)
    self.isShow = false
    self:updateState()
    gs.TransQuick:SizeDelta(self.UITrans, self.UITrans.sizeDelta.x, self:getHeight())
end

-- 获取动态高度
function getHeight(self)
    return 128
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71436):	"-未改造-"
	语言包: _TT(71435):	"点击改造"
]]

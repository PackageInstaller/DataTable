--[[ 
-----------------------------------------------------
@filename       : ManualHeroPanel
@Description    : 图鉴英雄面板
@date           : 2023-3-27 14:55:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualHeroPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualHeroPanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("manualHero_bg.jpg", false, "manual")
    self:setTxtTitle("战员图鉴")--战员图鉴
    self:setUICode(LinkCode.ManualHero)
end

function open(self, args)
    super.open(self, args)
end

function initData(self)
end

-- 初始化
function configUI(self)
end

-- 激活
function active(self, args)
    MoneyManager:setMoneyTidList({})
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateNew, self)
    self:updateView()
end

-- 非激活
function deActive(self)
    MoneyManager:setMoneyTidList({})
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateNew, self)
end

function updateView(self)
    for index = 1, 8 do
        local item = SimpleInsItem:create2(self:getChildGO("mCampItem" .. index))
        if manual.ManualHeroConst:getHeroCampList()[index] then
            local campVo = manual.ManualHeroConst:getHeroCampList()[index]
            item:getGo():SetActive(#manual.ManualHeroManager:getManualHeroCampDicListByCamp(campVo.camp) > 0)
            item:getChildGO("mNewTans"):SetActive(manual.ManualHeroManager:getIsNew(campVo.camp))
            item:getChildGO("mTxtCampName"):GetComponent(ty.Text).text = campVo.name
            item:getChildGO("mIconCamp"):GetComponent(ty.AutoRefImage):SetImg(campVo.url, true)
            item:getChildGO("mIconCampShadow"):GetComponent(ty.AutoRefImage):SetImg(campVo.url, true)
            item:addUIEvent(nil, function()
                GameDispatcher:dispatchEvent(EventName.OPEN_MANUALHERO_VIEW, { camp = campVo.camp, url = campVo.url, des = campVo.des, name = campVo.name })
            end)
        else
            item:getGo():SetActive(false)
        end
    end
end

function updateNew(self)
    for index = 1, 8 do
        local item = SimpleInsItem:create2(self:getChildGO("mCampItem" .. index))
        if manual.ManualHeroConst:getHeroCampList()[index] then
            local campVo = manual.ManualHeroConst:getHeroCampList()[index]
            item:getChildGO("mNewTans"):SetActive(manual.ManualHeroManager:getIsNew(campVo.camp))
        end
    end
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
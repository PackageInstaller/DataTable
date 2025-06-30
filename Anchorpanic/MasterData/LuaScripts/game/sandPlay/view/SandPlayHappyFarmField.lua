-- @FileName:   SandPlayHappyFarmField.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-17 11:40:13
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayHappyFarmField', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayHappyFarmField.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 1

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

end

--初始化UI
function configUI(self)
    self.tabContent = self:getChildTrans("tabContent")
    self.mTabItem = self:getChildGO("mTabItem")

    self.LyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.LyScroller:SetItemRender(sandPlay.SandPlayHappyFarmFieldItem)
end

function initViewText(self)
end

function addAllUIEvent(self)

end

--激活
function active(self, args)
    self:clearTabItem()
    for i = 1, 2 do
        local tabItem = SimpleInsItem:create(self.mTabItem, self.tabContent, "sandPlay_HappyFarm_FieldTabItem")
        table.insert(self.mTabItemList, tabItem)

        tabItem:getChildGO("mTextNormalLabel"):GetComponent(ty.Text).text = _TT(137016 + i)
        tabItem:getChildGO("mTextSelectLabel"):GetComponent(ty.Text).text = _TT(137016 + i)

        tabItem:getChildGO("mImgSelect"):SetActive(false)

        tabItem.select = function ()
            self:onTabSelect(i)
        end

        tabItem:addUIEvent(nil, function ()
            tabItem.select()
        end)
    end

    local selectTab = args.tab or 1
    self.mTabItemList[selectTab].select()
end

--非激活
function deActive(self)
    self:clearTabItem()
end

function onTabSelect(self, tabType)
    for key, tabItem in pairs(self.mTabItemList) do
        tabItem:getChildGO("mImgNormal"):SetActive(tabType ~= key)
        tabItem:getChildGO("mImgSelect"):SetActive(tabType == key)
    end

    local dataList = {}
    if tabType == 1 then
        local seedConfigList = sandPlay.SandPlayManager:getHappyFarmSeedConfigVoListByType(SandPlayConst.HappyFarm_Seed_Type.Crop)
        for seed_id, seedConfigVo in pairs(seedConfigList) do
            local vo = props.PropsManager:getTypePropsVoByTid(seedConfigVo.cost[1])
            vo.count = bag.BagManager:getPropsCountByTid(seedConfigVo.cost[1], bag.BagType.HappyFarm)

            table.insert(dataList, {propsVo = vo, type = tabType, seed_id = seed_id})
        end
    elseif tabType == 2 then
        local propsDic = bag.BagManager:getPropsDic(bag.BagType.HappyFarm)
        for id, propsVo in pairs(propsDic) do
            if (propsVo.type == PropsType.HAPPYFARM) then
                if propsVo.subType ~= 1 then
                    table.insert(dataList, {propsVo = propsVo, type = tabType})
                end
            end
        end
    end

    if self.LyScroller.Count <= 0 then
        self.LyScroller.DataProvider = dataList
    else
        self.LyScroller:ReplaceAllDataProvider(dataList)
    end
end

function clearTabItem(self)
    if self.mTabItemList then
        for k, v in pairs(self.mTabItemList) do
            v:poolRecover()
        end
    end

    self.mTabItemList = {}
end

return _M

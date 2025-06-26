--[[ 
-----------------------------------------------------
@filename       : DupEquipMainPanel
@Description    : 物资副本总入口
@Author         : Sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("dup.DupEquipMainPanel", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("dupEquip/DupEquipMainPanel.prefab")
panelType = 1


--构造函数
function ctor(self)
    super.ctor(self)   
    self:setUICode(LinkCode.DupDaily)
end

function initData(self)
    self.mDupItemList = {}
end


function configUI(self)
    self.mScrollContent = self:getChildTrans("Content")
end

function initViewText(self)

end

function addAllUIEvent(self)
end


function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})


    self:showDupList()
end


function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearItemList()
end

function showDupList(self)
    self:clearItemList()
    local dupList = dup.DupEquipMainManager:getDupEquipData()
    local openList = {}
    for i = 1 ,#dupList do 
        local vo = funcopen.FuncOpenManager:getFuncOpenData(dupList[i].funcId)
        local isOpen = funcopen.FuncOpenManager:isOpen(dupList[i].funcId,false)
        if vo.event == 1 or isOpen then
            table.insert(openList,dupList[i])
        end
    end

    for i = 1, #openList do
        local dupDailyConfigVo = openList[i]
        dupDailyConfigVo.scrollIndex = i
        local item = dup.DupEquipEnterItem:create(self.mScrollContent, dupDailyConfigVo,1,false)
        if dupDailyConfigVo.type == 2 then
             self:setGuideTrans("guide_DupEquipEnterItem_"..dupDailyConfigVo.type,item.mBtnGroup.transform)
        end
        table.insert(self.mDupItemList, item)
    end
end


function clearItemList(self)
    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]
        item:poolRecover()
    end
    self.mDupItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

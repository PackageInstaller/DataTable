--[[ 
-----------------------------------------------------
@filename       : InfiniteCitySupplyView
@Description    : 无限城补给携带选择页面
@date           : 2021-03-05 10:44:55
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCitySupplyView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCitySupplyView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mSupplyItemList = {}
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    self.mScollContent = self:getChildTrans("Content")
    self.mGroupRight = self:getChildTrans("mGroupRight")
end

--激活
function active(self, args)
    super.active(self, args)

    self.mDupData = args.dupData
    self.mGroupInfo = args.infoGroup

    self.mGroupInfoParent = self.mGroupInfo.transform.parent
    self.mGroupInfo.transform:SetParent(self.mGroupRight, false)
    self.mGroupInfoChildGos = GoUtil.GetChildHash(self.mGroupInfo)

    self:updateDisasterItem()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverSupplyItem()

    self.mGroupInfoChildGos["mImgArrow"]:SetActive(false)
    self.mGroupInfo.transform:SetParent(self.mGroupInfoParent, false)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function __playOpenAction(self)
end
function __closeOpenAction(self)
    self:close()
end

-- 更新补给显示
function updateDisasterItem(self)
    self:recoverSupplyItem()
    local list = infiniteCity.InfiniteCityManager:getSuppplyList()
    for i = 1, #list do
        local item = infiniteCity.InfiniteCitySupplyItem:poolGet()
        local supplyData = list[i]
        item:setData(self.mScollContent, supplyData)
        table.insert(self.mSupplyItemList, item)
    end
end

-- 回收项
function recoverSupplyItem(self)
    if self.mSupplyItemList then
        for i, v in pairs(self.mSupplyItemList) do
            v:poolRecover()
        end
    end
    self.mSupplyItemList = {}
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

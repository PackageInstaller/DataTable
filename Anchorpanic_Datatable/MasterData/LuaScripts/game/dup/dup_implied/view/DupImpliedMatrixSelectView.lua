--[[ 
-----------------------------------------------------
@filename       : DupImpliedMatrixSelectView
@Description    : 默示之境结算选矩阵
@date           : 2021-07-07 11:10:57
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.view.DupImpliedMatrixSelectView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedMatrixSelectView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mMatrixList = {}
    self.mSelectItem = nil
end

-- 初始化
function configUI(self)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mGroup = self:getChildTrans("mGroup")

end

--激活
function active(self, args)
    super.active(self, args)
    self.matrixList = args.buff_list
    self.cityId = args.city_id

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverList()
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
    self:addUIEvent(self.mBtnGet, self.onForgo)
end

function updateView(self)
    self:updateMatrixList()
end

function onForgo(self)
    if self.mSelectMatrixId == nil then return end
    GameDispatcher:dispatchEvent(EventName.REQ_DUP_IMPLIED_SELECT_MATRIX, { dupId = self.cityId, matrixId = self.mSelectMatrixId })
end

-- 更新战利品
function updateMatrixList(self)
    self:recoverList()
    for i = 1, #self.matrixList do
        local item = dup.DupImpliedMatrixSelectItem:poolGet()
        local data = dup.DupImpliedManager:getMatrixBaseData(self.matrixList[i].buff_id)
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mGroup, data, self.matrixList[i].improve_efficiency, self.cityId)
        table.insert(self.mMatrixList, item)
    end
end

-- 回收项
function recoverList(self)
    if self.mMatrixList then
        for i, v in pairs(self.mMatrixList) do
            v:removeEventListener(v.EVENT_CHANGE, self.onItemChange, self)
            v:poolRecover()
        end
    end
    self.mMatrixList = {}
end

function onItemChange(self, args)
    if self.showItem then
        -- 回收之前打开的
        self.showItem:setSelect(false)
        self.showItem = nil
    end
    self.showItem = args.item

    self.mSelectMatrixId = args.matrixId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

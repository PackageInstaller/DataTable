--[[ 
-----------------------------------------------------
@filename       : DupImpliedMatrixBookView
@Description    : 默示之境矩阵图鉴展示
@date           : 2021-07-07 11:10:34
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.view.DupImpliedMatrixBookView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedMatrixBookView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 1 --是否开启适配刘海

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemList = {}
end

-- 初始化
function configUI(self)

end

--激活
function active(self, args)
    super.active(self, args)

    self.list = self:getChildTrans("list")

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
end


function updateView(self)
    self:recoverItem()

    local config = dup.DupImpliedManager:getMatrixBaseConifg()
    local config_sort = {}
    for k,v in pairs(config) do
        table.insert(config_sort,v)
    end
    table.sort( config_sort, function (a,b)
        return a.skillId > b.skillId
    end )

     for i = 1, #config_sort do
        local item = dup.DupImpliedMatrixItem:poolGet()
        item:setData(self.list,config_sort[i])
        table.insert(self.mItemList, item)
    end
end

function recoverItem(self)
    for i = 1, #self.mItemList do
        local item = self.mItemList[i]
        item:poolRecover()
    end
    self.mItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

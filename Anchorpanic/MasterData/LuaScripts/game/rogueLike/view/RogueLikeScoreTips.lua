
module("rogueLike.RogueLikeScoreTips", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeScoreTips.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mScoreList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mScoreItem = self:getChildGO("mScoreItem")
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)

    self.mTxtDetailTitle = self:getChildGO("mTxtDetailTitle"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self)
    self:clearScoreList()

    local difficulty = rogueLike.RogueLikeManager:getRogueDifficulty()
    local scoreList = rogueLike.RogueLikeManager:getRogueLikeScoreData(difficulty)


    local function _sort(vo1, vo2)
        return vo1.id < vo2.id
    end
    table.sort(scoreList,_sort)

    for i =1,#scoreList do
        local item = SimpleInsItem:create(self.mScoreItem, self.mScrollView.content, "RogueLikeScoreTipsmScoreItem")
        item:getChildGO("mTxtScoreName"):GetComponent(ty.Text).text = _TT(scoreList[i].des)
        item:getChildGO("mTxtScoreNum"):GetComponent(ty.Text).text = scoreList[i].score
        table.insert(self.mScoreList, item)
    end
end

function clearScoreList(self)
    for i = 1, #self.mScoreList do
        self.mScoreList[i]:recover()
    end
    self.mScoreList = {}
end


-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearScoreList()
end

return _M
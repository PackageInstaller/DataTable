module("hero.HeroJobPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroJobPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mJobList = {hero.ProfessionType.OUTPUT, hero.ProfessionType.TANK, hero.ProfessionType.ASSISTER}
end

function configUI(self)
	super.configUI(self)
    self.mTextTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.mJobParent = self:getChildTrans("Content")
    self.mJobItem = self:getChildGO("JobItem")
end

function active(self, args)
    super.active(self, args)
    self:setData(args)
end

function deActive(self)
	super.deActive(self)
end

function initViewText(self)
    self.mTextTitle.text = _TT(1336)
end

function addAllUIEvent(self)
end

function setData(self, heroVo)
    self:__recover()
    for i = 1, #self.mJobList do
        local type = self.mJobList[i]
        local item = SimpleInsItem:create(self.mJobItem, self.mJobParent)
        item:getChildGO("ImgDefine"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroJobIconUrl(type), true)
        item:getChildGO("TextName"):GetComponent(ty.Text).text = hero.getProfessionName(type)
        item:getChildGO("TextDes"):GetComponent(ty.Text).text = hero.getPorfessionDes(type)
        table.insert(self.mJobItemList, item)
    end
end

function __recover(self)
    if(self.mJobItemList)then
        for i = 1, #self.mJobItemList do
            self.mJobItemList[i]:poolRecover()
        end
    end
    self.mJobItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1336):	"职业说明"
]]

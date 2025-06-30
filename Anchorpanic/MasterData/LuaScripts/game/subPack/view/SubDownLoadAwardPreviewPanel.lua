--[[ 
-----------------------------------------------------
@filename       : SubDownLoadAwardPreviewPanel
@Description    : 资源下载奖励包奖励预览
@date           : 2024年5月27日 10:00:00
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('subPack.SubDownLoadAwardPreviewPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("subPack/SubDownLoadAwardPreviewPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(828, 333)
    self:setTxtTitle(_TT(29543))
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mTransPorpsScroller = self:getChildTrans('PorpsScroller')
    self.mAwardContent = self:getChildTrans('AwardContent')
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

--激活
function active(self, args)
    super.active(self, args)
    self.data = args
    local title = args.title
    if title then 
        self:setTxtTitle(_TT(title))
    else
        self:setTxtTitle(_TT(29543))
    end
    self:__updateProps()
end

--非激活
function deActive(self)
    super.deActive(self)
end

function __updateProps(self)
    self:__removeItem()

    local propsList = AwardPackManager:getAwardListById(self.data.giftId)
    gs.TransQuick:LPosX(self.mAwardContent, 0)
    for i = 1, #propsList do
        local awardPackConfigVo = propsList[i]
        local propsGrid = PropsGrid:create(self.mAwardContent, {awardPackConfigVo.tid, awardPackConfigVo.num}, 0.9)
        propsGrid:setIsShowName(true)
        table.insert(self.m_awardList, propsGrid)
    end
    if(#propsList <= 5)then
        gs.TransQuick:SizeDelta01(self.mTransPorpsScroller, (#propsList * 128) + (15 * (#propsList - 1)))
    end
end

function __removeItem(self)
    if(self.m_awardList)then
        for i = #self.m_awardList, 1, -1 do
            local item = self.m_awardList[i]
            item:poolRecover()
            table.remove(self.m_awardList, i)
        end
    end
    self.m_awardList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

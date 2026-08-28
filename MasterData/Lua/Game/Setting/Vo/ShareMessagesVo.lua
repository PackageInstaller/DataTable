-------------------------------------------------------------------------------
-- 分享信息表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-07 11:53:56
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ShareMessagesVo : SettingRefBase
local ShareMessagesVo = Class("ShareMessagesVo", SettingRefBase)


function ShareMessagesVo:__init()
    ---@type Constants.ShareType @ 功能源id
    self.id = nil

    ---@type string @ 功能源名字
    self.name = nil

    ---@type Constants.ShareRewardsType @ 分享奖励类型id
    self.rewardTypeId = nil

    self.weiboDesc         = nil  -- 微博-正文
    self.weiboLink         = nil  -- 微博-连接
    self.weiboGroupName    = nil  -- 微博-超话
    --                     = 
    self.weiboGroupSection = nil  -- 微博-板块
    self.weixinDesc        = nil  -- 微信-正文
    self.weixinLink        = nil  -- 微信-连接
    --                     = 
    self.wxGroupDesc       = nil  -- 朋友圈-正文
    self.wxGroupLink       = nil  -- 朋友圈-连接
    --                     = 
    self.qqDesc            = nil  -- QQ-正文
    self.qqLink            = nil  -- QQ-连接
    --                     = 
    self.qqGroupDesc       = nil  -- QQ空间-正文
    self.qqGroupLink       = nil  -- QQ空间-连接
    --                     = 
    self.ftCommunityDesc   = nil  -- FT社区-正文
    self.ftCommunityLink   = nil  -- FT社区-连接
    self.ftCommunityTitle  = nil  -- FT社区-标题
    --                     = 
    self.facebookDesc      = nil -- facebook-正文
    self.facebookLink      = nil -- facebook-连接
    self.facebookShow      = nil -- facebook-开启
    --                     = 
    self.twitterDesc       = nil -- twitter-正文
    self.twitterLink       = nil -- twitter-连接
    self.twitterShow       = nil -- twitter-开启
    --                     = 
    self.instagramDesc     = nil -- instagram-正文
    self.instagramLink     = nil -- instagram-连接
    self.instagramShow     = nil -- instagram-开启
    --                     = 
    self.lineDesc          = nil -- line-正文
    self.lineLink          = nil -- line-连接
    self.lineShow          = nil -- line-开启

    self.discordDesc          = nil     -- discord
    self.discordLink          = nil   -- discord
    self.discordShow          = nil     -- discord
end


function ShareMessagesVo:__delete()
    self.id                = nil
    self.name              = nil
    self.rewardTypeId      = nil
    self.weiboDesc         = nil
    self.weiboLink         = nil
    self.weiboGroupName    = nil
    self.weiboGroupSection = nil
    self.weixinDesc        = nil
    self.weixinLink        = nil
    self.wxGroupDesc       = nil
    self.wxGroupLink       = nil
    self.qqDesc            = nil
    self.qqLink            = nil
    self.qqGroupDesc       = nil
    self.qqGroupLink       = nil
    self.ftCommunityDesc   = nil
    self.ftCommunityLink   = nil
    self.ftCommunityTitle  = nil
    self.facebookDesc      = nil
    self.facebookLink      = nil
    self.facebookShow      = nil
    self.twitterDesc       = nil
    self.twitterLink       = nil
    self.twitterShow       = nil
    self.instagramDesc     = nil
    self.instagramLink     = nil
    self.instagramShow     = nil
    self.lineDesc          = nil
    self.lineLink          = nil
    self.lineShow          = nil

    self.discordDesc          = nil
    self.discordLink          = nil
    self.discordShow          = nil
end


---@param row TableML.TableFileRow
function ShareMessagesVo:FillVo(row)
    SettingRefBase.FillVo(self,row)

    --[[
        字段名命名规则：修饰前缀 + 渠道id

        修饰前缀定义：
            itle      分享标题
            link      分享链接
            desc      分享正文
            groupName 超话字段
            show      是否开启（1显示，0关闭）

        渠道id定义：
            1、微博
            2、微信
            3、朋友圈
            4、QQ
            5、QQ空间
            6、番糖社区
            101、facebook
            102、twitter
            103、instagram
            104、line

        比如微博是1：
            desc1 微博分享文字
            link1 微博分享链接
            groupName1 微博超话字段
    ]]

    self.id                = parse_number(row, "Id")
    self.name              = parse_string(row, "name")
    self.rewardTypeId      = parse_string(row, "rewardType")
    --                     = 
    self.weiboDesc         = parse_localizeText(row, "desc1")
    self.weiboLink         = parse_string(row, "link1")
    self.weiboShow         = parse_string(row, "show1")
    --                     = 
    self.weiboGroupName    = parse_localizeText(row, "groupName1")
    self.weiboGroupSection = ''
    --                     = 
    self.weixinDesc        = parse_localizeText(row, "desc2")
    self.weixinLink        = parse_string(row, "link2")
    self.weixinShow        = parse_string(row, "show2")
    --                     = 
    self.wxGroupDesc       = parse_localizeText(row, "desc3")
    self.wxGroupLink       = parse_string(row, "link3")
    self.wxGroupShow       = parse_string(row, "show3")
    --                     = 
    self.qqDesc            = parse_localizeText(row, "desc4")
    self.qqLink            = parse_string(row, "link4")
    self.qqShow            = parse_string(row, "show4")
    --                     = 
    self.qqGroupDesc       = parse_localizeText(row, "desc5")
    self.qqGroupLink       = parse_string(row, "link5")
    self.qqGroupShow       = parse_string(row, "show5")
    --                     = 
    self.ftCommunityDesc   = parse_localizeText(row, "desc6")
    self.ftCommunityLink   = parse_string(row, "link6")
    self.ftCommunityTitle  = parse_localizeText(row, "title6")
    self.ftCommunityShow   = parse_string(row, "show6")
    --                     = 
    self.facebookDesc      = parse_localizeText(row, "desc101")
    self.facebookLink      = parse_localizeText(row, "link101")
    self.facebookShow      = parse_number(row, "show101")
    --                     = 
    self.twitterDesc       = parse_localizeText(row, "desc102")
    self.twitterLink       = parse_localizeText(row, "link102")
    self.twitterShow       = parse_number(row, "show102")
    --                     = 
    self.instagramDesc     = parse_localizeText(row, "desc103")
    self.instagramLink     = parse_localizeText(row, "link103")
    self.instagramShow     = parse_number(row, "show103")
    --                     = 
    self.lineDesc          = parse_localizeText(row, "desc104")
    self.lineLink          = parse_localizeText(row, "link104")
    self.lineShow          = parse_number(row, "show104")
    --                     = 
    self.discordDesc          = parse_localizeText(row, "desc105")
    self.discordLink          = parse_localizeText(row, "link105")  -- 2024.0122 目前此值为 nil
    self.discordShow          = parse_number(row, "show105")
end


return ShareMessagesVo

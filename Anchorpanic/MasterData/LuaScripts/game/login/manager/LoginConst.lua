login.IpList = {
    {"192.168.100.155", "8101", "内网A1"},
    {"192.168.100.155", "8102", "内网A2"},
    {"192.168.100.155", "8103", "内网A3"},
    {"192.168.20.180", "8101", "汉潜"},
    {"192.168.10.129", "8102", "跃欣"},
    {"192.168.10.86", "8102", "柱子"},
    {"192.168.20.238", "8101", "逸哥"},
}

login.IpList2 = {
    {"159.75.210.142", "8101", "A1外测包9001服", "307809001"},
    {"159.75.174.65", "8105", "A2外测包9004服", "300309004"},
    {"159.75.174.65", "8106", "A3外测包9008服", "399309008"},
    {"159.75.210.142", "8102", "线上镜像外测包9002服", "302110002"},
    {"42.194.138.70", "8106", "渠道线上镜像外测包9002服", "398809013"},
    {"159.75.174.65", "8109", "玩家体验服", "399109011"},

    {"192.168.90.165", "8101", "测试：骚阳"},
    {"192.168.30.71", "8101", "测试：骚阳2"},
    {"192.168.10.200", "8101", "测试：骚旭"},
    {"192.168.20.70", "8101", "测试：永婷"},
    {"192.168.60.26", "8510", "数值：陈异"},
}

login.getLoginResultTip = function(resultCode)
    local tip = ": 登录提示码：" .. resultCode
    if (resultCode == 0) then
        tip = "账号验证成功" .. tip
    elseif (resultCode == 1) then
        tip = "用户名为空" .. tip
    elseif (resultCode == 2) then
        tip = "IP被封" .. tip
    elseif (resultCode == 3) then
        tip = "服务器ID非法" .. tip
    elseif (resultCode == 4) then
        tip = "服务器注册账号已满" .. tip
    elseif (resultCode == 5) then
        tip = "账号被封" .. tip
    elseif (resultCode == 6) then
        tip = "账号防沉迷" .. tip
    elseif (resultCode == 7) then
        tip = "设备非法" .. tip
    elseif (resultCode == 8) then
        tip = "IP地址登录人数达上线" .. tip
    elseif (resultCode == 9) then
        tip = "渠道非法" .. tip
    elseif (resultCode == 10) then
        tip = "子渠道非法" .. tip
    elseif (resultCode == 11) then
        tip = "服务器初始化中" .. tip
    elseif (resultCode == 12) then
        tip = "用户创建失败" .. tip
    elseif (resultCode == 13) then
        tip = "设备码验证失败" .. tip
    elseif (resultCode == 14) then
        tip = "加密串验证失败" .. tip
    elseif (resultCode == 15) then
        tip = "注册时间限制" .. tip
    elseif (resultCode == 20) then
        tip = "创角失败" .. tip
    elseif (resultCode == 21) then
        tip = "登录失败" .. tip
    end
    return tip
end

--[[ 替换语言包自动生成，请勿修改！
]]

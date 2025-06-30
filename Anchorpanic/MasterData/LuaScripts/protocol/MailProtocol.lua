-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    16     
-- @Name:  mail   
-- @Desc:  邮件协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 请求邮件列表 16000
CS_MAIL_LIST =
{
    16000,
}
 
--- *s2c* 返回邮件列表 16001
SC_MAIL_LIST =
{
    16001, 
    {"mail_list", pt_mail_info, "邮件列表", "repeated"},
}
 
--- *s2c* 返回新增邮件 16002
SC_MAIL_ADD =
{
    16002, 
    {"mail_info", pt_mail_info, "邮件信息"},
}
 
--- *c2s* 请求删除邮件 16003
CS_MAIL_DEL =
{
    16003, 
    {"mail_id_list", "int32", "邮件id列表", "repeated"},
}
 
--- *s2c* 返回删除邮件id列表 16004
SC_MAIL_DEL =
{
    16004, 
    {"mail_id_list", "int32", "邮件id列表", "repeated"},
}
 
--- *c2s* 请求设置邮件已阅读 16005
CS_MAIL_READ =
{
    16005, 
    {"mail_id_list", "int32", "邮件id列表", "repeated"},
}
 
--- *s2c* 返回已阅读邮件id列表 16006
SC_MAIL_READ =
{
    16006, 
    {"mail_id_list", "int32", "邮件id列表", "repeated"},
}
 
--- *c2s* 请求领取邮件的附件 16007
CS_MAIL_ENCLOSURE_REC =
{
    16007, 
    {"mail_id_list", "int32", "邮件id列表", "repeated"},
}
 
--- *s2c* 返回已领取附件的邮件id列表 16008
SC_MAIL_ENCLOSURE_REC =
{
    16008, 
    {"rec_result", "int8", "领取结果"}, 
    {"mail_id_list", "int32", "邮件id列表", "repeated"},
}
 
--- *c2s* 请求收藏邮件列表 16009
CS_COLLECTION_MAIL_LIST =
{
    16009,
}
 
--- *s2c* 返回收藏邮件列表 16010
SC_COLLECTION_MAIL_LIST =
{
    16010, 
    {"mail_list", pt_mail_info, "收藏邮件列表", "repeated"},
}
 
--- *c2s* 请求删除收藏邮件 16011
CS_COLLECTION_MAIL_DEL =
{
    16011, 
    {"mail_id_list", "int32", "邮件id列表", "repeated"},
}
 
--- *s2c* 返回删除收藏邮件id列表 16012
SC_COLLECTION_MAIL_DEL =
{
    16012, 
    {"mail_id_list", "int32", "收藏邮件id列表", "repeated"},
}
 
--- *c2s* 请求添加收藏邮件 16013
CS_COLLECTION_MAIL_ADD =
{
    16013, 
    {"mail_id", "int32", "邮件id"},
}
 
--- *s2c* 请求添加收藏邮件 16014
SC_COLLECTION_MAIL_ADD =
{
    16014, 
    {"mail_info", pt_mail_info, "邮件信息"}, 
    {"result", "int8", "领取结果 0-成功,1-背包已满,2-其他错误,3-战员背包已满,4-邮件达到上限"},
}

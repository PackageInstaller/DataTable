LuaS �

xV           (w@A@../PublishResources/lua/product/module/gamble/gamble_module.lua         m    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@���@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �& � %   _classGambleModuleGameModuleConstructorGetPrizePoolsGetPoolDrawTimesCheckAlreadyGainFiveStarCardGetPrizePoolExtandData_GetPrizePoolExternInfo GetNotIncludePetPoolGambleTimesGetNotIncludePetPoolGetCfgOptionalPoolIdGetOptionalPoolIsOpenOptionalCheckOptionalRedGetOptionalPoolComfirmDBKeyOptionalPoolComfirmLoadDBOptionalPoolComfirmSaveDBOptionalPoolAlert	GetProbsGetCounterNumApplyAllPoolInfoHandleOptionalPoolReqSetAllPoolInfoShakeGetReasonByErrorCodeInitContextClearContextContextSetShowPoolCountCalcGetShowPoolCountCalcHasFreeDraw_Multi
IsNewPoolHasNewPool_GetNewPoolLocalDBKeyGetIntervalStartTimeCancelPoolNew    "              K   
@ �
���K   
@��K   
@ �
���
���K   
@ �K   
@��& � 
   _prizePoolList_uiContext _gambleConfig_gambleExternInfo_showPoolCountCalc hasShowNotIncluePedPoolTipspool_2_timespool_five_star                    	   	                                 self                      G @ f  & �    _prizePoolList                       self                      � @ �@ �  & �    pool_2_times                          self       poolId               &       � @ �@@ � � ��� @ ��� � ��  *A��   �  & �    pairspool_five_star                            !   !   "   "           %   %   &      self       poolId       (for generator)   
   (for state)   
   (for control)   
   _      v         _ENV +   2    
   � @ �@@ � ��ǁ@��  �� �@GA�A � ��  *A��   �  & �    pairs_prizePoolListprize_pool_idclose_typeextend_data            ,   ,   ,   ,   -   -   -   .   .   .   .   .   ,   ,   1   1   2      self       poolID       (for generator)      (for state)      (for control)      k      v         _ENV 4   ?       � @ �@��@  @ �  & ��"A  @ �D  f & & �    _gambleExternInfo           5   5   6   6   7   7   :   ;   ;   <   <   >   ?      self       index       ext_info_type       l_pool_extern_map      l_extern_info           D   L       � @  � FA@ G���� �@  @ ���  �  � A�  & �    _GetPrizePoolExternInfoEPrizePoolExtInfoTypeEPPEIT_NIPP��������times            F   F   F   F   F   G   G   H   H   K   K   L      self       index       l_nipp_extern_info         _ENV Q   Y       � @  � FA@ G���� �@  @ ��   �  ��@�  & �    _GetPrizePoolExternInfoEPrizePoolExtInfoTypeEPPEIT_NIPPparam_pool            S   S   S   S   S   T   T   U   U   X   X   Y      self       index       l_nipp_extern_info         _ENV ^   e       � @  � FA@ G���� �@  @ ���  �  � A�  & �    _GetPrizePoolExternInfoEPrizePoolExtInfoTypeEPPEIT_OPP��������id            `   `   `   `   `   a   a   b   b   d   d   e      self       index       l_op_extern_info         _ENV j   x    	   � @  � FA@ G���� �@  @ ��   �  �   �@ AF�@ GA��� (�����B�_@B� �B�� �'���  & � 
   _GetPrizePoolExternInfoEPrizePoolExtInfoTypeEPPEIT_OPPElementTypeElementType_BlueElementType_Yellow               param_pool             l   l   l   l   l   m   m   n   n   p   q   q   q   q   q   q   r   s   s   s   s   t   t   t   q   w   x      self       index       l_op_extern_info      
l_ret_map
      (for index)      (for limit)      (for step)      i         _ENV z   �       � @  � ����@@ ǀ�ǀ��@ A_@� �� L�A �� d���B ���� �_�A  �AB��  *��@�  �CA  C� � f�& � 
   GetCfgOptionalPoolIdCfgcfg_optional_poolElementTypeElementType_Yellow         GetOptionalPoolpairs                   {   {   {   |   |   |   }   }   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       index       idOptional      cfgOptional      	selCount      selWish      (for generator)      (for state)      (for control)      sk      sv         _ENV �   �       �   � @ �@��@ �� $��� ��  @ A@ �  �A  � & & �    ElementTypeElementType_YellowIsOpenOptional            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       index       isOpenOptional      	selCount         _ENV �   �    
   A   �@@ �@ �����@�  � ] �f  & �    "GambleModule::OptionalPoolComfirm
GetModuleRoleModule	GetPstId         
   �   �   �   �   �   �   �   �   �   �      self    
   dbKey   
   roleModule   
      _ENV �   �       L @ d� �@@ ��@� � �  ���� A �@�� @ 䀀�A @�$� @ d�� �  
���AB ���@ ��B ʂ��  *��& � 
   GetOptionalPoolComfirmDBKeyLocalDB
GetStringstringformatreturn {%s}load_optionalPoolComfirmpairs            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       dbKey      content      	fnString      fnTable      dbData      (for generator)      (for state)      (for control)      k      v         _ENV �   �       A   �@@ ǀ@ � ���� �@ AAB � $��] ���  *����A �� ��A � �  @� �@�& � 	   pairs_optionalPoolComfirmstringformat%d, GetOptionalPoolComfirmDBKeyLocalDB
SetString            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       content      (for generator)      (for state)      (for control)      k      v      dbKey         _ENV �   �    g     C  �  �A@ @� ���� @�bA   ����A� �  � ��b   �Ɓ@ ���� ����A� �  � � ��A � B�AAǁA ��@ ��B �A ǁA ��_��� ����A� @��  A $� FBB � d� ��C��C���i�  ��K  �BB ǂA ���ǃ��� �ƃB ��� �@ �C���  *C��BB ���@ �ǃA ��A��  *����A ��C �B �BC ��C�� D CDF�D G��� �CE ǃ�� � ,  D  �D  �  �B �� � �  � & �            IsOpenOptionalElementTypeElementType_YellowGetPrizePoolsperformance_id_optionalPoolComfirm OptionalPoolComfirmLoadDBpairstableinsertOptionalPoolComfirmSaveDBPopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxType	OkCancelStringTableGet"str_draw_card_wishsel_drawcomfirm         �   �       E   d@� & �               �   �   �      param          
comfirmCB �   �       E   d@� & �               �   �   �      param          	cancelCBg   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    g   
poolIndex    g   
comfirmCB    g   	cancelCB    g   
idRecruit   g   isOpenOptional   g   
wishCount   g   awardPools      allOpenPool+   d   awardPools-   d   (for generator)0   6   (for state)0   6   (for control)0   6   k1   4   v1   4   rmList7   d   (for generator):   E   (for state):   E   (for control):   E   k;   C   v;   C   (for generator)H   M   (for state)H   M   (for control)H   M   kI   K   vI   K      _ENV �      =   � @ �@ _@@ �ƀ@   � @�����@ � �A �@ �� � � ���A B AB� � F�A �B ��B��d� ��A �B ������� ��A B C� �A FB GB�GB$� F�A �B ��C��d� !@�� ��B�����C��@ ��  � �B��BD��& �    _gambleConfig nextLogfatal(haven't prob config when calculate prob        	tonumberFishForStateTypeFFST_InirateFFST_NormalCounterFFST_Maxtime
FFST_StepFFST_AddRateFFST_Active       �      
                =   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                 
  
                             self    =   index    =   state   =   prob_01   =   prob_02   =   counter   =   maxTime    =   step%   =   addRate*   =   active/   =   	redouble3   5      _ENV         � @ �@ _@@ �ƀ@   � @�@���@ � �A �@ �� �  ��A B AB�  �   & � 
   _gambleConfig nextLogfatal(haven't prob config when calculate prob��������	tonumberFishForStateTypeFFST_NormalCounter                                                           self       index       state         _ENV    6   :   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_����L�B�  dA�L�B� dA��  L�B�� dA�GAC��B���A��AC�D
����AC��D
����  
����E �AC�A��� ���D ��ʂ��  *���AC��E
����AC�F
���  & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventApplyAllPoolInfoCallresCallResultTypeNormalSetSucc
SetResult��������msgret_prizePoolListall_prize_pool_gambleConfigstate_info_gambleExternInfopairspool_extern_info       pool_2_timespool_five_star         :   !  !  !  #  #  #  #  #  #  $  $  $  $  %  %  %  %  %  &  &  &  '  '  '  (  *  *  *  +  ,  ,  ,  -  -  -  .  .  .  /  /  0  0  0  0  0  1  1  1  0  0  3  3  3  4  4  4  5  6     self    :   TT    :   res   :   request	   :   reply   :   replyEvent   :   (for generator),   2   (for state),   2   (for control),   2   key-   0   value-   0      _ENV =  V   0   L@ � B@ �@d� bA  � ���@ �A� �AA ��A�� ��AB ����������������AC @� � � ��F�C G�_@� ��@ BD& ��G�D�E �BE��@�G����EJ��F�@ G�f G�DMB�f & �    _GetPrizePoolExternInfoEPrizePoolExtInfoTypeEPPEIT_OPPGAMBLE_CODEGAMBLE_OPTIONAL_POOL_INVALIDNetMessageFactoryGetInstanceCreateMessageCEventOptionalPoolReqnIndexnOptionalPoolIdidnOptionalVecCallresCallResultTypeNormalGAMBLE_SERVER_NORESPONSEmsgnRetCOMMON_RANDOM_CODECOMMON_RANDOM_SUCCESSparam_pool       GAMBLE_SUCCESSd                0   >  >  >  >  >  ?  ?  @  @  @  D  D  D  D  D  D  E  F  F  G  H  H  H  H  I  I  I  I  I  J  J  J  N  P  P  P  P  P  Q  Q  Q  R  R  R  U  U  U  V  	   self    0   TT    0   index    0   pet_element    0   nOptionalVec    0   l_optional_pool_ex_info   0   request   0   reply   0   replyEvent!   0      _ENV X  Z      
@ �& �    _prizePoolList           Y  Z     self       all_prize_pool            ]  v   <   �@ �A@�� Ɓ@ ���� ��FBA 䁀ʁ ��������A���B �� ��$� G�B�C �BC_��@�L�C�  dB�L�C�D �B�dB�@ �  f�L�C�� dB�G�D��C���B��  �E C�����E D@$� 
ă�
DF�\ MD����  jC��   G�������& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventShakeshake_typeprize_pool_idcost_idcost_countCallresCallResultTypeNormalSetSucc
SetResultGAMBLE_CODEGAMBLE_SERVER_NORESPONSEmsgretpairsaward_cards
RoleAssetassetidcount       exchange_markfixed_reward         <   ^  ^  ^  `  `  `  `  `  `  a  b  c  d  e  e  e  e  f  f  f  f  f  g  g  g  h  h  h  h  i  i  i  k  k  k  l  m  m  m  n  o  o  o  o  p  p  p  q  r  s  s  s  o  o  u  u  u  u  u  v     self    <   TT    <   
shakeType    <   prizePoolId    <   costId    <   
costCount    <   res   <   request	   <   reply   <   replyEvent$   <   award_role_asset(   <   (for generator)+   6   (for state)+   6   (for control)+   6   k,   4   v,   4   tmp_role_asset/   4      _ENV x  �   9   � @ �@@��  ���@ ��@�  �  �   � @ �@A��  ���@ ��@�� �  �   � @ ��A��  ���@ ��@�  �  �   � @ �@B��  ���@ ��@�� �  �   � @ ��B��  ���@ ��@�  �  �   � @ �@C��  ���@ ��@�� �  �   �� �  & �    GAMBLE_CODEGAMBLE_SERVER_NORESPONSEStringTableGet'str_draw_card_gamble_server_noresponseGAMBLE_SUCCESSstr_draw_card_gamble_successGAMBLE_POOL_UNEXIST"str_draw_card_gamble_pool_unexistGAMBLE_COST_UNENOUGH$str_draw_card_gameble_cost_unenoughGAMBLE_SHAKETYPE_ERROR&str_draw_card_gameble_shaketype_errorGAMBLE_COST_ERROR!str_draw_card_gameble_cost_errorgamble error         9   y  y  y  y  z  z  z  z  z  |  |  |  |  }  }  }  }  }          �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    9   code    9      _ENV �  �      �@@ ��@ � ���
� �& �    _uiContextDrawCardUIContextNew            �  �  �  �  �  �     self       	sceneReq          _ENV �  �      G @ L@� d@ 
�@�& �    _uiContextDispose            �  �  �  �  �     self            �  �      G @ f  & �    _uiContext           �  �  �     self            �  �      
@ �& �    _showPoolCountCalc           �  �     self       value            �  �      G @ f  & �    _showPoolCountCalc           �  �  �     self            �  �      L @ d� �@@ � � �  �ǁ@ ���@ ��� � ��  *��   �  & �    GetPrizePoolsipairsmul_remain_free_count                    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       pools      (for generator)      (for state)      (for control)      _      pool         _ENV �  �      � @  � ����@@ ǀ�  A�  䀀_��  ��@  � � �  & �    _GetNewPoolLocalDBKeyLocalDBGetInt                    �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       pool       newKey      new         _ENV �  �   "   L @ d� �@@ � � � ��Ɓ@ ���A���A   �BA �AA� �A$B�B ��$��LBB � d��b  � �_�B@ �C� f ��  *���   �  & �    GetPrizePoolsipairsCfgcfg_recruit_pool_viewperformance_idLog
exception&cfg_recruit_pool_view中缺少配置:GetIntervalStartTime
IsNewPool��������         "   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	   self    "   pools   "   (for generator)      (for state)      (for control)      _      pool      cfg
      
startTime         _ENV �  �   
   � � �@@ ǀ�䀀 ���� A AAG�� A"A   �F�A G��A ǁ� dA�L�B � d������   @��A� & �    prize_pool_idGameGlobal
GameLogic
GetOpenIdCfgcfg_recruit_pool_viewperformance_idLog
exception&cfg_recruit_pool_view中缺少配置:GetIntervalStartTime_RecruitPoolNew_            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       pool       id      openId      cfg
      
startTime      newKey         _ENV �  �   8   � @ �@@ǀ� �� �@  @ ���  �  � A�@  @ ���  �  �@A ǀ��A � AA �AFB $� "  ��FAB G����B�� �Cd� bA    �A�  �AC �A���̂�G�C�D �CD� ����D�D �C�$�   �� � @�  �� ��  *���� � & �    Cfgcfg_gamble_pool_putawayID        OpenTimeIntervalGameGlobal
GetModuleLoginModuleSvrTimeModulemathfloorGetServerTime����MbP?pairsGetTimeStampByTimeStr       Enum_DateTimeZoneTypeE_ZoneType_GMT       ��������         8   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    8   cfg    8   poolCfg   8   loginModule   8   svrTimeModule   8   curTime    8   (for generator)#   5   (for state)#   5   (for control)#   5   _$   3   timePairArray$   3   
startTime)   3   endTime.   3      _ENV �  �   	   � @  � ����@@ ǀ�  A�  �@�& �    _GetNewPoolLocalDBKeyLocalDBSetInt                	   �  �  �  �  �  �  �  �  �     self    	   pool    	   newKey   	      _ENVm                                                   &      +   2   +   4   ?   4   D   L   D   Q   Y   Q   ^   e   ^   j   x   j   z   �   z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �            6     =  V  =  X  Z  X  ]  v  ]  x  �  x  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV
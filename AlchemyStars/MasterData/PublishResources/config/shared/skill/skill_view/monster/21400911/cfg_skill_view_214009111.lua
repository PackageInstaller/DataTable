LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/21400911/cfg_skill_view_214009111.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 3083,audioType=1; PlayCasterBindEffect,effectID =1772; PlayCasterBindEffect,effectID =1774; PlaySelectGridEffect,effectID =1773,intervalTime=0; Wait,waitTime=4800; �
      � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         &                                                                                                                        key	   &   config!   &      _ENV
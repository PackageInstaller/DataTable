LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/4900251/cfg_skill_view_490025102.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAbsorbPhantom,flyDuration=1000,eftID=657,phantomDeadAnim=Birth,phantomDeadDuration=700,eftPosYa=0.7,eftPosYb=2.4,commonEft=655; PlayAudio,audioID = 5025,audioType=1; Wait,waitTime=1000; �      � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         %                                                                                                                     key   %   config    %      _ENV
LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905001/cfg_skill_view_290500124.lua         e   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� � kB� �@�� ��  A�  �� ��  B  AB �� �� �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B �� � A +C� kA����A B A� ��  �� � K� J���J�E�JCF�J�F�JCF�J�ǎJȏJ�ȐJɑJ�ɒJʓ�A���� A� �� ��  � A� �� �C
 �C� �A��AB �B �� �  AC �� �� �
 �C� +B�k@�� � �      �  & � +   ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               d       < PlaySummonDeadTrap,trapID=29050012,interval=0,effectID=0; �      ��       PlayEntityAnimation,animName=birth,trapID=29050012; PlayEntityBindEffect , effectID=290500114,trapID=29050012; PlayAudio,audioID = 6256,audioType=1; PlayTargetMaterialAnim,animName=effanim_29050012_birth; Wait,waitTime=2500; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,delay=0,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; E PlaySummonMonsterBySummonEveryThing,monsterID=20024012,interval=0; �       PlayCasterBindEffect,effectID =290500105; PlayCasterBindEffect,effectID =290500106; PlayCasterAnimation,animName=skill01; PlayAudio,audioID = 6273,audioType=3; Wait,waitTime=2000; PlayStageTeleport,type=3, onlySelf=1,stageIndex=3; PlayCasterControlGridDown,enable=0; stageIndexteleportAnimskill03teleportStartWaitTime,      jumpEffectID�k�    teleportTimeteleportFinishWaitTime�      	moveAnimskill04moveEffectID�k�    
moveSpeed       flyOneTime2       hitEffectID�k�    ; Wait,waitTime=500; PlayAudio,audioID = 6258,audioType=1; �v       PlayStageTeleport,type=5, onlySelf=1,stageIndex=3; PlayRotateResult; PlayChangeBodyArea; PlayStageTeleport,type=6, onlySelf=1,stageIndex=3; PlayCasterBindEffect,effectID =290500107; PlayCasterBindEffect,effectID =290500108; PlayCasterAnimation,animName=skill01(2); PlayCasterControlGridDown,enable=1; Wait,waitTime=1700; PlayStageTeleport,type=9, onlySelf=1,stageIndex=3;         e                                                                                                                                                                                                                                                                  	   	   	   	   	   	   	   	   	   	   
                     key   e   config`   e      _ENV
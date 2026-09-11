return {
	Play104092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104092001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_3 = "B04c"

			if arg_1_1.bgs_.B04c == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.B04c:GetComponent("SpriteRenderer")

				if var_4_5 then
					arg_1_1.var_.alphaOldValueB04c = var_4_5.color.a
					arg_1_1.var_.alphaMatValueB04c = var_4_5
				end

				arg_1_1.var_.alphaOldValueB04c = 0
			end

			local var_4_6 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 then
				if arg_1_1.var_.alphaMatValueB04c then
					arg_1_1.var_.alphaMatValueB04c.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB04c, 1, (arg_1_1.time_ - 0) / var_4_6)
					arg_1_1.var_.alphaMatValueB04c.color = arg_1_1.var_.alphaMatValueB04c.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and arg_1_1.var_.alphaMatValueB04c then
				arg_1_1.var_.alphaMatValueB04c.color.a = 1
				arg_1_1.var_.alphaMatValueB04c.color = arg_1_1.var_.alphaMatValueB04c.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B04c

				arg_1_1.bgs_.B04c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_10 + 2 and arg_1_1.time_ < var_4_10 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.675

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(104092001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 27 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 27)

				if (27 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 27)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104092002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104092002
		arg_8_1.duration_ = 5.37

		local var_8_0 = {
			ja = 5.366,
			ko = 3.933,
			zh = 3.566,
			en = 5.066
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104092003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1084ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1084ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1084ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1084ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_6.localPosition
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_11_8 = "mmr"

			if arg_8_1.actors_.mmr == nil then
				local var_11_9 = Object.Instantiate(arg_8_1.imageGo_, arg_8_1.canvasGo_.transform)

				var_11_9.transform:SetSiblingIndex(1)

				var_11_9.name = var_11_8

				local var_11_10 = var_11_9:GetComponent(typeof(Image))

				var_11_10.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "mmr")

				var_11_10:SetNativeSize()

				var_11_9.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_8_1.actors_[var_11_8] = var_11_9
			end

			local var_11_11 = arg_8_1.actors_.mmr.transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.shakeOldPosmmr = var_11_11.localPosition
			end

			local var_11_12 = 2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_12 then
				local var_11_13, var_11_14 = math.modf((arg_8_1.time_ - 0) / 0.066)

				var_11_11.localPosition = Vector3.New(var_11_14 * 0.13, var_11_14 * 0.13, var_11_14 * 0.13) + arg_8_1.var_.shakeOldPosmmr
			end

			if arg_8_1.time_ >= 0 + var_11_12 and arg_8_1.time_ < 0 + var_11_12 + arg_11_0 then
				var_11_11.localPosition = arg_8_1.var_.shakeOldPosmmr
			end

			local var_11_15 = 0
			local var_11_16 = 0.5

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_17 = arg_8_1:GetWordFromCfg(104092002)
				local var_11_18 = arg_8_1:FormatText(var_11_17.content)

				arg_8_1.text_.text = var_11_18

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_20 = 20 <= 0 and var_11_16 or var_11_16 * (utf8.len(var_11_18) / 20)

				if (20 <= 0 and var_11_16 or var_11_16 * (utf8.len(var_11_18) / 20)) > 0 and var_11_16 < var_11_20 then
					arg_8_1.talkMaxDuration = var_11_20

					if var_11_20 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_15
					end
				end

				arg_8_1.text_.text = var_11_18
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092002", "story_v_out_104092.awb") ~= 0 then
					local var_11_21 = manager.audio:GetVoiceLength("story_v_out_104092", "104092002", "story_v_out_104092.awb") / 1000

					if var_11_21 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_15
					end

					if var_11_17.prefab_name ~= "" and arg_8_1.actors_[var_11_17.prefab_name] ~= nil then
						local var_11_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_17.prefab_name].transform, "story_v_out_104092", "104092002", "story_v_out_104092.awb")

						arg_8_1:RecordAudio("104092002", var_11_22)
						arg_8_1:RecordAudio("104092002", var_11_22)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104092", "104092002", "story_v_out_104092.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104092", "104092002", "story_v_out_104092.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_23 = math.max(var_11_16, arg_8_1.talkMaxDuration)

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_23 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_15) / var_11_23

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_15 + var_11_23 and arg_8_1.time_ < var_11_15 + var_11_23 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play104092003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104092003
		arg_12_1.duration_ = 7.73

		local var_12_0 = {
			ja = 7,
			ko = 7.733,
			zh = 6.933,
			en = 6.466
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104092004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_12_1.stage_.transform)

				var_15_0.name = "10001_tpose"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["10001_tpose"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["10001_tpose" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["10001_tpose" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["10001_tpose"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect10001_tpose == nil then
				arg_12_1.var_.characterEffect10001_tpose = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect10001_tpose and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect10001_tpose then
				arg_12_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 and not isNil(var_15_6) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_6) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_7)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_15_8 = arg_12_1.actors_["10001_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10001_tpose = var_15_8.localPosition

				local var_15_9 = GameObjectTools.GetOrAddComponent(var_15_8.gameObject, typeof(DynamicBoneHelper))

				if var_15_9 then
					var_15_9:EnableDynamicBone(false)
				end
			end

			local var_15_10 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_10 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10001_tpose, Vector3.New(0.7, -1.23, -5.8), (arg_12_1.time_ - 0) / var_15_10)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_10 and arg_12_1.time_ < 0 + var_15_10 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0.7, -1.23, -5.8)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles

				local var_15_11 = GameObjectTools.GetOrAddComponent(var_15_8.gameObject, typeof(DynamicBoneHelper))

				if var_15_11 then
					var_15_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_15_12 = 0
			local var_15_13 = 0.775

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_14 = arg_12_1:GetWordFromCfg(104092003)
				local var_15_15 = arg_12_1:FormatText(var_15_14.content)

				arg_12_1.text_.text = var_15_15

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_17 = 30 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 30)

				if (30 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 30)) > 0 and var_15_13 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_12
					end
				end

				arg_12_1.text_.text = var_15_15
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092003", "story_v_out_104092.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_104092", "104092003", "story_v_out_104092.awb") / 1000

					if var_15_18 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_12
					end

					if var_15_14.prefab_name ~= "" and arg_12_1.actors_[var_15_14.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_14.prefab_name].transform, "story_v_out_104092", "104092003", "story_v_out_104092.awb")

						arg_12_1:RecordAudio("104092003", var_15_19)
						arg_12_1:RecordAudio("104092003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104092", "104092003", "story_v_out_104092.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104092", "104092003", "story_v_out_104092.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_13, arg_12_1.talkMaxDuration)

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_12) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_12 + var_15_20 and arg_12_1.time_ < var_15_12 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play104092004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104092004
		arg_16_1.duration_ = 8.4

		local var_16_0 = {
			ja = 8.4,
			ko = 3.9,
			zh = 5.8,
			en = 5.8
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104092005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1019ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1019ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1019ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1019ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1019ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["10001_tpose"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect10001_tpose == nil then
				arg_16_1.var_.characterEffect10001_tpose = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect10001_tpose and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_16_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect10001_tpose then
				arg_16_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_16_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_19_8 = arg_16_1.actors_["10001_tpose"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10001_tpose = var_19_8.localPosition

				local var_19_9 = GameObjectTools.GetOrAddComponent(var_19_8.gameObject, typeof(DynamicBoneHelper))

				if var_19_9 then
					var_19_9:EnableDynamicBone(false)
				end
			end

			local var_19_10 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_10 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_10)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_10 and arg_16_1.time_ < 0 + var_19_10 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, 100, 0)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles

				local var_19_11 = GameObjectTools.GetOrAddComponent(var_19_8.gameObject, typeof(DynamicBoneHelper))

				if var_19_11 then
					var_19_11:EnableDynamicBone(true)
				end
			end

			local var_19_12 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_12.localPosition
			end

			local var_19_13 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_13 then
				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_13)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_13 and arg_16_1.time_ < 0 + var_19_13 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(0, 100, 0)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			local var_19_14 = arg_16_1.actors_["1019ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_14.localPosition
			end

			local var_19_15 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_15 then
				var_19_14.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_16_1.time_ - 0) / var_19_15)
				var_19_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_14.position).x, (manager.ui.mainCamera.transform.position - var_19_14.position).y, (manager.ui.mainCamera.transform.position - var_19_14.position).z)
				var_19_14.localEulerAngles.z = 0
				var_19_14.localEulerAngles.x = 0
				var_19_14.localEulerAngles = var_19_14.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_15 and arg_16_1.time_ < 0 + var_19_15 + arg_19_0 then
				var_19_14.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_19_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_14.position).x, (manager.ui.mainCamera.transform.position - var_19_14.position).y, (manager.ui.mainCamera.transform.position - var_19_14.position).z)
				var_19_14.localEulerAngles.z = 0
				var_19_14.localEulerAngles.x = 0
				var_19_14.localEulerAngles = var_19_14.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_19_16 = 0
			local var_19_17 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(104092004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_21 = 18 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_19) / 18)

				if (18 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_19) / 18)) > 0 and var_19_17 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_16
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092004", "story_v_out_104092.awb") ~= 0 then
					local var_19_22 = manager.audio:GetVoiceLength("story_v_out_104092", "104092004", "story_v_out_104092.awb") / 1000

					if var_19_22 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_16
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_out_104092", "104092004", "story_v_out_104092.awb")

						arg_16_1:RecordAudio("104092004", var_19_23)
						arg_16_1:RecordAudio("104092004", var_19_23)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104092", "104092004", "story_v_out_104092.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104092", "104092004", "story_v_out_104092.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_24 = math.max(var_19_17, arg_16_1.talkMaxDuration)

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_24 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_16) / var_19_24

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_16 + var_19_24 and arg_16_1.time_ < var_19_16 + var_19_24 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104092005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104092005
		arg_20_1.duration_ = 4.63

		local var_20_0 = {
			ja = 4.433,
			ko = 3.933,
			zh = 3.666,
			en = 4.633
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play104092006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1036ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1036ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1036ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1036ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1036ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1036ui_story == nil then
				arg_20_1.var_.characterEffect1036ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect1036ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1036ui_story then
				arg_20_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_23_6 = arg_20_1.actors_["1019ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_6) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 and not isNil(var_23_6) then
				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_6) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_7)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 and not isNil(var_23_6) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_23_8 = arg_20_1.actors_["1019ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_8.localPosition
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_9)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0, 100, 0)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			local var_23_10 = arg_20_1.actors_["1036ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1036ui_story = var_23_10.localPosition
			end

			local var_23_11 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 then
				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_20_1.time_ - 0) / var_23_11)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(0, -1.09, -5.78)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action7_1")
			end

			local var_23_12 = manager.ui.mainCamera.transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.shakeOldPos = var_23_12.localPosition
			end

			local var_23_13 = 0.3

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_13 then
				local var_23_14, var_23_15 = math.modf((arg_20_1.time_ - 0) / 0.099)

				var_23_12.localPosition = Vector3.New(var_23_15 * 0.13, var_23_15 * 0.13, var_23_15 * 0.13) + arg_20_1.var_.shakeOldPos
			end

			if arg_20_1.time_ >= 0 + var_23_13 and arg_20_1.time_ < 0 + var_23_13 + arg_23_0 then
				var_23_12.localPosition = arg_20_1.var_.shakeOldPos
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_23_16 = 0
			local var_23_17 = 0.35

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(104092005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 14 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 14)

				if (14 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 14)) > 0 and var_23_17 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21

					if var_23_21 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092005", "story_v_out_104092.awb") ~= 0 then
					local var_23_22 = manager.audio:GetVoiceLength("story_v_out_104092", "104092005", "story_v_out_104092.awb") / 1000

					if var_23_22 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_16
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_104092", "104092005", "story_v_out_104092.awb")

						arg_20_1:RecordAudio("104092005", var_23_23)
						arg_20_1:RecordAudio("104092005", var_23_23)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104092", "104092005", "story_v_out_104092.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104092", "104092005", "story_v_out_104092.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_24 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_16) / var_23_24

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_16 + var_23_24 and arg_20_1.time_ < var_23_16 + var_23_24 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play104092006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104092006
		arg_24_1.duration_ = 3.63

		local var_24_0 = {
			ja = 3.166,
			ko = 2.666,
			zh = 3.4,
			en = 3.633
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104092007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story", "se_story_quake", "")
			end

			local var_27_1 = arg_24_1.actors_["1084ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 and not isNil(var_27_1) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_1) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1036ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1036ui_story == nil then
				arg_24_1.var_.characterEffect1036ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_5 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 and not isNil(var_27_4) then
				if arg_24_1.var_.characterEffect1036ui_story and not isNil(var_27_4) then
					arg_24_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_5)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1036ui_story then
				arg_24_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_27_6 = arg_24_1.actors_["1036ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1036ui_story = var_27_6.localPosition
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_6.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_7)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_6.localPosition = Vector3.New(0, 100, 0)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			local var_27_8 = arg_24_1.actors_["1084ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, -0.97, -6)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_27_10 = manager.ui.mainCamera.transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.shakeOldPos = var_27_10.localPosition
			end

			local var_27_11 = 0.3

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_11 then
				local var_27_12, var_27_13 = math.modf((arg_24_1.time_ - 0) / 0.099)

				var_27_10.localPosition = Vector3.New(var_27_13 * 0.13, var_27_13 * 0.13, var_27_13 * 0.13) + arg_24_1.var_.shakeOldPos
			end

			if arg_24_1.time_ >= 0 + var_27_11 and arg_24_1.time_ < 0 + var_27_11 + arg_27_0 then
				var_27_10.localPosition = arg_24_1.var_.shakeOldPos
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_27_14 = 0
			local var_27_15 = 0.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(104092006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 12 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 12)

				if (12 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 12)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092006", "story_v_out_104092.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_104092", "104092006", "story_v_out_104092.awb") / 1000

					if var_27_20 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_14
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_104092", "104092006", "story_v_out_104092.awb")

						arg_24_1:RecordAudio("104092006", var_27_21)
						arg_24_1:RecordAudio("104092006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104092", "104092006", "story_v_out_104092.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104092", "104092006", "story_v_out_104092.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_22 and arg_24_1.time_ < var_27_14 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play104092007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104092007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104092008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_31_0 = 0.600000023841858

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				local var_31_1, var_31_2 = math.modf((arg_28_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_31_2 * 0.13, var_31_2 * 0.13, var_31_2 * 0.13) + arg_28_1.var_.shakeOldPosMainCamera
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				manager.ui.mainCamera.transform.localPosition = arg_28_1.var_.shakeOldPosMainCamera
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4134")
			end

			local var_31_3 = manager.ui.mainCamera.transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_3.localPosition
			end

			local var_31_4 = 0.3

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				local var_31_5, var_31_6 = math.modf((arg_28_1.time_ - 0) / 0.066)

				var_31_3.localPosition = Vector3.New(var_31_6 * 0.13, var_31_6 * 0.13, var_31_6 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = arg_28_1.var_.shakeOldPos
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_31_7 = 0
			local var_31_8 = 0.125

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_9 = arg_28_1:GetWordFromCfg(104092007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_12 = 5 <= 0 and var_31_8 or var_31_8 * (utf8.len(var_31_10) / 5)

				if (5 <= 0 and var_31_8 or var_31_8 * (utf8.len(var_31_10) / 5)) > 0 and var_31_8 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_7 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_7
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092007", "story_v_out_104092.awb") ~= 0 then
					local var_31_13 = manager.audio:GetVoiceLength("story_v_out_104092", "104092007", "story_v_out_104092.awb") / 1000

					if var_31_13 + var_31_7 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_7
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_104092", "104092007", "story_v_out_104092.awb")

						arg_28_1:RecordAudio("104092007", var_31_14)
						arg_28_1:RecordAudio("104092007", var_31_14)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104092", "104092007", "story_v_out_104092.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104092", "104092007", "story_v_out_104092.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_15 = math.max(var_31_8, arg_28_1.talkMaxDuration)

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_15 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_7) / var_31_15

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_7 + var_31_15 and arg_28_1.time_ < var_31_7 + var_31_15 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104092008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104092008
		arg_32_1.duration_ = 2.53

		local var_32_0 = {
			ja = 2.533,
			ko = 1.966,
			zh = 2.1,
			en = 2.3
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play104092009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1084ui_story"]) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = arg_32_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1084ui_story"]) then
				if arg_32_1.var_.characterEffect1084ui_story and not isNil(arg_32_1.actors_["1084ui_story"]) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1084ui_story"]) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_35_1 = arg_32_1.actors_["1084ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_1.localPosition
			end

			local var_35_2 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 then
				var_35_1.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_2)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 then
				var_35_1.localPosition = Vector3.New(0, 100, 0)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			local var_35_3 = 0
			local var_35_4 = 0.225

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_5 = arg_32_1:GetWordFromCfg(104092008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 9 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 9)

				if (9 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 9)) > 0 and var_35_4 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092008", "story_v_out_104092.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_104092", "104092008", "story_v_out_104092.awb") / 1000

					if var_35_9 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_3
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_104092", "104092008", "story_v_out_104092.awb")

						arg_32_1:RecordAudio("104092008", var_35_10)
						arg_32_1:RecordAudio("104092008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104092", "104092008", "story_v_out_104092.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104092", "104092008", "story_v_out_104092.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_11 and arg_32_1.time_ < var_35_3 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104092009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104092009
		arg_36_1.duration_ = 3.5

		local var_36_0 = {
			ja = 3.5,
			ko = 3.033,
			zh = 2.866,
			en = 3.1
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play104092010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_39_0 = 0.600000023841858

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				local var_39_1, var_39_2 = math.modf((arg_36_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_39_2 * 0.13, var_39_2 * 0.13, var_39_2 * 0.13) + arg_36_1.var_.shakeOldPosMainCamera
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				manager.ui.mainCamera.transform.localPosition = arg_36_1.var_.shakeOldPosMainCamera
			end

			local var_39_3 = 0
			local var_39_4 = 0.325

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_5 = arg_36_1:GetWordFromCfg(104092009)
				local var_39_6 = arg_36_1:FormatText(var_39_5.content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_8 = 13 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_6) / 13)

				if (13 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_6) / 13)) > 0 and var_39_4 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_3
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092009", "story_v_out_104092.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_104092", "104092009", "story_v_out_104092.awb") / 1000

					if var_39_9 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_3
					end

					if var_39_5.prefab_name ~= "" and arg_36_1.actors_[var_39_5.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_5.prefab_name].transform, "story_v_out_104092", "104092009", "story_v_out_104092.awb")

						arg_36_1:RecordAudio("104092009", var_39_10)
						arg_36_1:RecordAudio("104092009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104092", "104092009", "story_v_out_104092.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104092", "104092009", "story_v_out_104092.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_4, arg_36_1.talkMaxDuration)

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_3) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_3 + var_39_11 and arg_36_1.time_ < var_39_3 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104092010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104092010
		arg_40_1.duration_ = 11.9

		local var_40_0 = {
			ja = 8.966,
			ko = 6.9,
			zh = 11.9,
			en = 8.533
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104092011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1019ui_story = arg_40_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1019ui_story"].transform.position).z)
				arg_40_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1019ui_story"].transform.localEulerAngles = arg_40_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1019ui_story"].transform.position).z)
				arg_40_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1019ui_story"].transform.localEulerAngles = arg_40_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_43_1 = 0
			local var_43_2 = 0.75

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[63].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4012")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(104092010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 30 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 30)

				if (30 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 30)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092010", "story_v_out_104092.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_104092", "104092010", "story_v_out_104092.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_104092", "104092010", "story_v_out_104092.awb")

						arg_40_1:RecordAudio("104092010", var_43_8)
						arg_40_1:RecordAudio("104092010", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104092", "104092010", "story_v_out_104092.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104092", "104092010", "story_v_out_104092.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_9 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_9 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_9

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_9 and arg_40_1.time_ < var_43_1 + var_43_9 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play104092011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104092011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104092012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.825

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(104092011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 73 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 73)

				if (73 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 73)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104092012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104092012
		arg_48_1.duration_ = 6.87

		local var_48_0 = {
			ja = 6.866,
			ko = 5.6,
			zh = 5.1,
			en = 5.5
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play104092013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_51_0 = 0.600000023841858

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				local var_51_1, var_51_2 = math.modf((arg_48_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_51_2 * 0.13, var_51_2 * 0.13, var_51_2 * 0.13) + arg_48_1.var_.shakeOldPosMainCamera
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				manager.ui.mainCamera.transform.localPosition = arg_48_1.var_.shakeOldPosMainCamera
			end

			local var_51_3 = 0
			local var_51_4 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_3 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_5 = arg_48_1:GetWordFromCfg(104092012)
				local var_51_6 = arg_48_1:FormatText(var_51_5.content)

				arg_48_1.text_.text = var_51_6

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_8 = 23 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_6) / 23)

				if (23 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_6) / 23)) > 0 and var_51_4 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_3
					end
				end

				arg_48_1.text_.text = var_51_6
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092012", "story_v_out_104092.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_104092", "104092012", "story_v_out_104092.awb") / 1000

					if var_51_9 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_3
					end

					if var_51_5.prefab_name ~= "" and arg_48_1.actors_[var_51_5.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_5.prefab_name].transform, "story_v_out_104092", "104092012", "story_v_out_104092.awb")

						arg_48_1:RecordAudio("104092012", var_51_10)
						arg_48_1:RecordAudio("104092012", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104092", "104092012", "story_v_out_104092.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104092", "104092012", "story_v_out_104092.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_4, arg_48_1.talkMaxDuration)

			if var_51_3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_3 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_3) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_3 + var_51_11 and arg_48_1.time_ < var_51_3 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play104092013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104092013
		arg_52_1.duration_ = 3.4

		local var_52_0 = {
			ja = 3.4,
			ko = 3,
			zh = 2.6,
			en = 3.1
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play104092014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_55_0 = 0.600000023841858

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				local var_55_1, var_55_2 = math.modf((arg_52_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_55_2 * 0.13, var_55_2 * 0.13, var_55_2 * 0.13) + arg_52_1.var_.shakeOldPosMainCamera
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				manager.ui.mainCamera.transform.localPosition = arg_52_1.var_.shakeOldPosMainCamera
			end

			local var_55_3 = 0
			local var_55_4 = 0.275

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_5 = arg_52_1:GetWordFromCfg(104092013)
				local var_55_6 = arg_52_1:FormatText(var_55_5.content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_8 = 11 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 11)

				if (11 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 11)) > 0 and var_55_4 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_3
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092013", "story_v_out_104092.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_104092", "104092013", "story_v_out_104092.awb") / 1000

					if var_55_9 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_3
					end

					if var_55_5.prefab_name ~= "" and arg_52_1.actors_[var_55_5.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_5.prefab_name].transform, "story_v_out_104092", "104092013", "story_v_out_104092.awb")

						arg_52_1:RecordAudio("104092013", var_55_10)
						arg_52_1:RecordAudio("104092013", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104092", "104092013", "story_v_out_104092.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104092", "104092013", "story_v_out_104092.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_4, arg_52_1.talkMaxDuration)

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_3) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_3 + var_55_11 and arg_52_1.time_ < var_55_3 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104092014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104092014
		arg_56_1.duration_ = 3.9

		local var_56_0 = {
			ja = 3.9,
			ko = 2.4,
			zh = 3,
			en = 3.1
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104092015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.275

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:GetWordFromCfg(104092014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 11 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 11)

				if (11 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 11)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092014", "story_v_out_104092.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_104092", "104092014", "story_v_out_104092.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_104092", "104092014", "story_v_out_104092.awb")

						arg_56_1:RecordAudio("104092014", var_59_6)
						arg_56_1:RecordAudio("104092014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104092", "104092014", "story_v_out_104092.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104092", "104092014", "story_v_out_104092.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play104092015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104092015
		arg_60_1.duration_ = 20.4

		local var_60_0 = {
			ja = 20.4,
			ko = 9.566,
			zh = 8.866,
			en = 9.1
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play104092016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.625

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(104092015)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 25 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 25)

				if (25 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 25)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092015", "story_v_out_104092.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_104092", "104092015", "story_v_out_104092.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_104092", "104092015", "story_v_out_104092.awb")

						arg_60_1:RecordAudio("104092015", var_63_6)
						arg_60_1:RecordAudio("104092015", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104092", "104092015", "story_v_out_104092.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104092", "104092015", "story_v_out_104092.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play104092016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104092016
		arg_64_1.duration_ = 1.93

		local var_64_0 = {
			ja = 1.933,
			ko = 1.333,
			zh = 1.766,
			en = 1.366
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104092017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.1

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(104092016)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 4 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 4)

				if (4 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 4)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092016", "story_v_out_104092.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_104092", "104092016", "story_v_out_104092.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_104092", "104092016", "story_v_out_104092.awb")

						arg_64_1:RecordAudio("104092016", var_67_6)
						arg_64_1:RecordAudio("104092016", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104092", "104092016", "story_v_out_104092.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104092", "104092016", "story_v_out_104092.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play104092017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104092017
		arg_68_1.duration_ = 13.2

		local var_68_0 = {
			ja = 13.2,
			ko = 6.4,
			zh = 9.766,
			en = 9.633
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play104092018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.975

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(104092017)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 34 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 34)

				if (34 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 34)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104092", "104092017", "story_v_out_104092.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_104092", "104092017", "story_v_out_104092.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_104092", "104092017", "story_v_out_104092.awb")

						arg_68_1:RecordAudio("104092017", var_71_6)
						arg_68_1:RecordAudio("104092017", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104092", "104092017", "story_v_out_104092.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104092", "104092017", "story_v_out_104092.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play104092018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104092018
		arg_72_1.duration_ = 11.03

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
			arg_72_1.auto_ = false
		end

		function arg_72_1.playNext_(arg_74_0)
			arg_72_1.onStoryFinished_()
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				local var_75_0 = arg_72_1.bgs_.B04c:GetComponent("SpriteRenderer")

				if var_75_0 then
					arg_72_1.var_.alphaOldValueB04c = var_75_0.color.a
					arg_72_1.var_.alphaMatValueB04c = var_75_0
				end

				arg_72_1.var_.alphaOldValueB04c = 1
			end

			local var_75_1 = 1.5

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				if arg_72_1.var_.alphaMatValueB04c then
					arg_72_1.var_.alphaMatValueB04c.color.a = Mathf.Lerp(arg_72_1.var_.alphaOldValueB04c, 0, (arg_72_1.time_ - 0) / var_75_1)
					arg_72_1.var_.alphaMatValueB04c.color = arg_72_1.var_.alphaMatValueB04c.color
				end
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 and arg_72_1.var_.alphaMatValueB04c then
				arg_72_1.var_.alphaMatValueB04c.color.a = 0
				arg_72_1.var_.alphaMatValueB04c.color = arg_72_1.var_.alphaMatValueB04c.color
			end

			local var_75_2 = "S0406"

			if arg_72_1.bgs_.S0406 == nil then
				local var_75_3 = Object.Instantiate(arg_72_1.paintGo_)

				var_75_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_75_2)
				var_75_3.name = var_75_2
				var_75_3.transform.parent = arg_72_1.stage_.transform
				var_75_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.bgs_[var_75_2] = var_75_3
			end

			if 1.5 < arg_72_1.time_ and arg_72_1.time_ <= 1.5 + arg_75_0 then
				local var_75_4 = arg_72_1.bgs_.S0406:GetComponent("SpriteRenderer")

				if var_75_4 then
					arg_72_1.var_.alphaOldValueS0406 = var_75_4.color.a
					arg_72_1.var_.alphaMatValueS0406 = var_75_4
				end

				arg_72_1.var_.alphaOldValueS0406 = 0
			end

			local var_75_5 = 1.5

			if 1.5 <= arg_72_1.time_ and arg_72_1.time_ < 1.5 + var_75_5 then
				if arg_72_1.var_.alphaMatValueS0406 then
					arg_72_1.var_.alphaMatValueS0406.color.a = Mathf.Lerp(arg_72_1.var_.alphaOldValueS0406, 1, (arg_72_1.time_ - 1.5) / var_75_5)
					arg_72_1.var_.alphaMatValueS0406.color = arg_72_1.var_.alphaMatValueS0406.color
				end
			end

			if arg_72_1.time_ >= 1.5 + var_75_5 and arg_72_1.time_ < 1.5 + var_75_5 + arg_75_0 and arg_72_1.var_.alphaMatValueS0406 then
				arg_72_1.var_.alphaMatValueS0406.color.a = 1
				arg_72_1.var_.alphaMatValueS0406.color = arg_72_1.var_.alphaMatValueS0406.color
			end

			local var_75_6 = arg_72_1.bgs_.B04c.transform

			if 1.5 < arg_72_1.time_ and arg_72_1.time_ <= 1.5 + arg_75_0 then
				arg_72_1.var_.moveOldPosB04c = var_75_6.localPosition
			end

			local var_75_7 = 0.001

			if 1.5 <= arg_72_1.time_ and arg_72_1.time_ < 1.5 + var_75_7 then
				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPosB04c, Vector3.New(0, 100, 10), (arg_72_1.time_ - 1.5) / var_75_7)
			end

			if arg_72_1.time_ >= 1.5 + var_75_7 and arg_72_1.time_ < 1.5 + var_75_7 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, 100, 10)
			end

			local var_75_8 = arg_72_1.bgs_.S0406.transform

			if 5.53333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 5.53333333333333 + arg_75_0 then
				arg_72_1.var_.moveOldPosS0406 = var_75_8.localPosition
			end

			local var_75_9 = 0.001

			if 5.53333333333333 <= arg_72_1.time_ and arg_72_1.time_ < 5.53333333333333 + var_75_9 then
				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPosS0406, Vector3.New(0, 100, 10), (arg_72_1.time_ - 5.53333333333333) / var_75_9)
			end

			if arg_72_1.time_ >= 5.53333333333333 + var_75_9 and arg_72_1.time_ < 5.53333333333333 + var_75_9 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(0, 100, 10)
			end

			local var_75_10 = 5.03333333333333

			if 5.03333333333333 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_11 = 0.5

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 then
				local var_75_12 = Color.New(1, 1, 1)

				var_75_12.a = Mathf.Lerp(0, 1, (arg_72_1.time_ - var_75_10) / var_75_11)
				arg_72_1.mask_.color = var_75_12
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 then
				local var_75_13 = Color.New(1, 1, 1)

				var_75_13.a = 1
				arg_72_1.mask_.color = var_75_13
			end

			local var_75_14 = 5.53333333333333

			if 5.53333333333333 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_15 = 0.5

			if var_75_14 <= arg_72_1.time_ and arg_72_1.time_ < var_75_14 + var_75_15 then
				local var_75_16 = Color.New(1, 1, 1)

				var_75_16.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_14) / var_75_15)
				arg_72_1.mask_.color = var_75_16
			end

			if arg_72_1.time_ >= var_75_14 + var_75_15 and arg_72_1.time_ < var_75_14 + var_75_15 + arg_75_0 then
				local var_75_17 = Color.New(1, 1, 1)

				arg_72_1.mask_.enabled = false
				var_75_17.a = 0
				arg_72_1.mask_.color = var_75_17
			end

			if 1.5 < arg_72_1.time_ and arg_72_1.time_ <= 1.5 + arg_75_0 then
				local var_75_18 = arg_72_1.bgs_.S0406

				arg_72_1.bgs_.S0406.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_75_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_19 = var_75_18:GetComponent("SpriteRenderer")

				if var_75_19 and var_75_19.sprite then
					local var_75_20 = 2 * (var_75_18.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_75_18.transform.localScale = Vector3.New(var_75_20 / var_75_19.sprite.bounds.size.y < var_75_20 * manager.ui.mainCameraCom_.aspect / var_75_19.sprite.bounds.size.x and var_75_20 * manager.ui.mainCameraCom_.aspect / var_75_19.sprite.bounds.size.x or var_75_20 / var_75_19.sprite.bounds.size.y, var_75_20 / var_75_19.sprite.bounds.size.y < var_75_20 * manager.ui.mainCameraCom_.aspect / var_75_19.sprite.bounds.size.x and var_75_20 * manager.ui.mainCameraCom_.aspect / var_75_19.sprite.bounds.size.x or var_75_20 / var_75_19.sprite.bounds.size.y, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "S0406" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_21 = manager.ui.mainCamera.transform

			if 4.6 < arg_72_1.time_ and arg_72_1.time_ <= 4.6 + arg_75_0 then
				arg_72_1.var_.shakeOldPos = var_75_21.localPosition
			end

			local var_75_22 = 0.6

			if 4.6 <= arg_72_1.time_ and arg_72_1.time_ < 4.6 + var_75_22 then
				local var_75_23, var_75_24 = math.modf((arg_72_1.time_ - 4.6) / 0.066)

				var_75_21.localPosition = Vector3.New(var_75_24 * 0.13, var_75_24 * 0.13, var_75_24 * 0.13) + arg_72_1.var_.shakeOldPos
			end

			if arg_72_1.time_ >= 4.6 + var_75_22 and arg_72_1.time_ < 4.6 + var_75_22 + arg_75_0 then
				var_75_21.localPosition = arg_72_1.var_.shakeOldPos
			end

			local var_75_25 = "S0406a"

			if arg_72_1.bgs_.S0406a == nil then
				local var_75_26 = Object.Instantiate(arg_72_1.paintGo_)

				var_75_26:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_75_25)
				var_75_26.name = var_75_25
				var_75_26.transform.parent = arg_72_1.stage_.transform
				var_75_26.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.bgs_[var_75_25] = var_75_26
			end

			local var_75_27 = arg_72_1.bgs_.S0406a.transform

			if 5.53333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 5.53333333333333 + arg_75_0 then
				arg_72_1.var_.moveOldPosS0406a = var_75_27.localPosition
			end

			local var_75_28 = 0.001

			if 5.53333333333333 <= arg_72_1.time_ and arg_72_1.time_ < 5.53333333333333 + var_75_28 then
				var_75_27.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPosS0406a, Vector3.New(0, 1, 9), (arg_72_1.time_ - 5.53333333333333) / var_75_28)
			end

			if arg_72_1.time_ >= 5.53333333333333 + var_75_28 and arg_72_1.time_ < 5.53333333333333 + var_75_28 + arg_75_0 then
				var_75_27.localPosition = Vector3.New(0, 1, 9)
			end

			local var_75_29 = arg_72_1.bgs_.S0406.transform

			if 2.86666666666667 < arg_72_1.time_ and arg_72_1.time_ <= 2.86666666666667 + arg_75_0 then
				arg_72_1.var_.moveOldPosS0406 = var_75_29.localPosition
			end

			local var_75_30 = 1.46666666666667

			if 2.86666666666667 <= arg_72_1.time_ and arg_72_1.time_ < 2.86666666666667 + var_75_30 then
				var_75_29.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPosS0406, Vector3.New(0, 1, 9), (arg_72_1.time_ - 2.86666666666667) / var_75_30)
			end

			if arg_72_1.time_ >= 2.86666666666667 + var_75_30 and arg_72_1.time_ < 2.86666666666667 + var_75_30 + arg_75_0 then
				var_75_29.localPosition = Vector3.New(0, 1, 9)
			end

			local var_75_31 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_31 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_31 + 6.03333333333333 and arg_72_1.time_ < var_75_31 + 6.03333333333333 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_32 = 6.03333333333333
			local var_75_33 = 0.0166666666666663

			if 6.03333333333333 < arg_72_1.time_ and arg_72_1.time_ <= var_75_32 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_34 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_34:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_35 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(104092018).content)

				arg_72_1.text_.text = var_75_35

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_37 = 2 <= 0 and var_75_33 or var_75_33 * (utf8.len(var_75_35) / 2)

				if (2 <= 0 and var_75_33 or var_75_33 * (utf8.len(var_75_35) / 2)) > 0 and var_75_33 < var_75_37 then
					arg_72_1.talkMaxDuration = var_75_37
					var_75_32 = var_75_32 + 0.3

					if var_75_37 + var_75_32 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_37 + var_75_32
					end
				end

				arg_72_1.text_.text = var_75_35
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_38 = var_75_32 + 0.3
			local var_75_39 = math.max(var_75_33, arg_72_1.talkMaxDuration)

			if var_75_32 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_38 + var_75_39 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_38) / var_75_39

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_38 + var_75_39 and arg_72_1.time_ < var_75_38 + var_75_39 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B04c",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0406",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333334,
				className = "StoryMoveNode",
				startTime = 5.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0406a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 5.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0406",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.46666666666667,
				className = "StoryMoveNode",
				startTime = 2.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04c",
		"TextureConfig/Background/S0406"
	},
	voices = {
		"story_v_out_104092.awb"
	}
}

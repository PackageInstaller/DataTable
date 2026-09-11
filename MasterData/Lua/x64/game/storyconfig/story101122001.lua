return {
	Play112201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_4_0.name = "H02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H02

				arg_1_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.7

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112201001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 28 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 28)

				if (28 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 28)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112201002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112201002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play112201003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(112201002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 4 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 4)

				if (4 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 4)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play112201003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112201003
		arg_12_1.duration_ = 5.3

		local var_12_0 = {
			ja = 5.3,
			ko = 4.1,
			zh = 3.233,
			en = 4
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
				arg_12_0:Play112201004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1148ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1148ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1148ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1148ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_15_3 = arg_12_1.actors_["1148ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1148ui_story == nil then
				arg_12_1.var_.characterEffect1148ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1148ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1148ui_story then
				arg_12_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1148ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1148ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, -0.8, -6.2)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			local var_15_8 = 0
			local var_15_9 = 0.3

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(112201003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 12 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 12)

				if (12 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 12)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201003", "story_v_out_112201.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_112201", "112201003", "story_v_out_112201.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_112201", "112201003", "story_v_out_112201.awb")

						arg_12_1:RecordAudio("112201003", var_15_15)
						arg_12_1:RecordAudio("112201003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_112201", "112201003", "story_v_out_112201.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_112201", "112201003", "story_v_out_112201.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play112201004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112201004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play112201005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1148ui_story"]) and arg_16_1.var_.characterEffect1148ui_story == nil then
				arg_16_1.var_.characterEffect1148ui_story = arg_16_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1148ui_story"]) then
				if arg_16_1.var_.characterEffect1148ui_story and not isNil(arg_16_1.actors_["1148ui_story"]) then
					arg_16_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1148ui_story"]) and arg_16_1.var_.characterEffect1148ui_story then
				arg_16_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.05

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(112201004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 2 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 2)

				if (2 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 2)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_6 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_6 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_6

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_6 and arg_16_1.time_ < var_19_1 + var_19_6 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play112201005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112201005
		arg_20_1.duration_ = 5.33

		local var_20_0 = {
			ja = 5.333,
			ko = 3.1,
			zh = 2.466,
			en = 3.466
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
				arg_20_0:Play112201006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1148ui_story = arg_20_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_23_0 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				arg_20_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).z)
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles = arg_20_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				arg_20_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1148ui_story"].transform.position).z)
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1148ui_story"].transform.localEulerAngles = arg_20_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_23_1 = "1027ui_story"

			if arg_20_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_20_1.stage_.transform)

				var_23_2.name = var_23_1
				var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_1] = var_23_2

				local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

				var_23_3.enabled = true

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_3.transform, false)

				arg_20_1.var_[var_23_1 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_1 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_1 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_5 = arg_20_1.actors_["1027ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1027ui_story = var_23_5.localPosition
			end

			local var_23_6 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_20_1.time_ - 0) / var_23_6)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_23_7 = arg_20_1.actors_["1027ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1027ui_story == nil then
				arg_20_1.var_.characterEffect1027ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect1027ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1027ui_story then
				arg_20_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_23_10 = 0
			local var_23_11 = 0.3

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(112201005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 12 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 12)

				if (12 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 12)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201005", "story_v_out_112201.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_112201", "112201005", "story_v_out_112201.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_112201", "112201005", "story_v_out_112201.awb")

						arg_20_1:RecordAudio("112201005", var_23_17)
						arg_20_1:RecordAudio("112201005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_112201", "112201005", "story_v_out_112201.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_112201", "112201005", "story_v_out_112201.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play112201006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112201006
		arg_24_1.duration_ = 5.03

		local var_24_0 = {
			ja = 5.033,
			ko = 4.933,
			zh = 4.066,
			en = 3.8
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
				arg_24_0:Play112201007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "1084ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1084ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["1084ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["1084ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["1084ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_3.localPosition
			end

			local var_27_4 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_24_1.time_ - 0) / var_27_4)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_27_5 = arg_24_1.actors_["1084ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 and not isNil(var_27_5) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_27_8 = arg_24_1.actors_["1027ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.characterEffect1027ui_story == nil then
				arg_24_1.var_.characterEffect1027ui_story = var_27_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_9 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 and not isNil(var_27_8) then
				if arg_24_1.var_.characterEffect1027ui_story and not isNil(var_27_8) then
					arg_24_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_9)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.characterEffect1027ui_story then
				arg_24_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_27_10 = 0
			local var_27_11 = 0.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
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

				local var_27_12 = arg_24_1:GetWordFromCfg(112201006)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 12 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 12)

				if (12 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 12)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201006", "story_v_out_112201.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_112201", "112201006", "story_v_out_112201.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_112201", "112201006", "story_v_out_112201.awb")

						arg_24_1:RecordAudio("112201006", var_27_17)
						arg_24_1:RecordAudio("112201006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112201", "112201006", "story_v_out_112201.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112201", "112201006", "story_v_out_112201.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_18 and arg_24_1.time_ < var_27_10 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play112201007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112201007
		arg_28_1.duration_ = 9.57

		local var_28_0 = {
			ja = 9.566,
			ko = 8.6,
			zh = 8.433,
			en = 8.466
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play112201008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = arg_28_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).z)
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles = arg_28_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).z)
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles = arg_28_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1027ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1027ui_story = var_31_1.localPosition
			end

			local var_31_2 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 then
				var_31_1.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_2)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 then
				var_31_1.localPosition = Vector3.New(0, 100, 0)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			local var_31_3 = "1039ui_story"

			if arg_28_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_31_4 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_28_1.stage_.transform)

				var_31_4.name = var_31_3
				var_31_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_[var_31_3] = var_31_4

				local var_31_5 = var_31_4:GetComponentInChildren(typeof(CharacterEffect))

				var_31_5.enabled = true

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_4, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_5.transform, false)

				arg_28_1.var_[var_31_3 .. "Animator"] = var_31_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_[var_31_3 .. "Animator"].applyRootMotion = true
				arg_28_1.var_[var_31_3 .. "LipSync"] = var_31_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_7 = arg_28_1.actors_["1039ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1039ui_story = var_31_7.localPosition
			end

			local var_31_8 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_8 then
				var_31_7.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_28_1.time_ - 0) / var_31_8)
				var_31_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_7.position).x, (manager.ui.mainCamera.transform.position - var_31_7.position).y, (manager.ui.mainCamera.transform.position - var_31_7.position).z)
				var_31_7.localEulerAngles.z = 0
				var_31_7.localEulerAngles.x = 0
				var_31_7.localEulerAngles = var_31_7.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_8 and arg_28_1.time_ < 0 + var_31_8 + arg_31_0 then
				var_31_7.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_31_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_7.position).x, (manager.ui.mainCamera.transform.position - var_31_7.position).y, (manager.ui.mainCamera.transform.position - var_31_7.position).z)
				var_31_7.localEulerAngles.z = 0
				var_31_7.localEulerAngles.x = 0
				var_31_7.localEulerAngles = var_31_7.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_9 = arg_28_1.actors_["1039ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1039ui_story == nil then
				arg_28_1.var_.characterEffect1039ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_10 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_10 and not isNil(var_31_9) then
				if arg_28_1.var_.characterEffect1039ui_story and not isNil(var_31_9) then
					arg_28_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_10 and arg_28_1.time_ < 0 + var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1039ui_story then
				arg_28_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_31_12 = 0
			local var_31_13 = 1.025

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(112201007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 41 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 41)

				if (41 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 41)) > 0 and var_31_13 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201007", "story_v_out_112201.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_112201", "112201007", "story_v_out_112201.awb") / 1000

					if var_31_18 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_12
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_112201", "112201007", "story_v_out_112201.awb")

						arg_28_1:RecordAudio("112201007", var_31_19)
						arg_28_1:RecordAudio("112201007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_112201", "112201007", "story_v_out_112201.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_112201", "112201007", "story_v_out_112201.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_20 and arg_28_1.time_ < var_31_12 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play112201008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112201008
		arg_32_1.duration_ = 7.73

		local var_32_0 = {
			ja = 7.733,
			ko = 4.833,
			zh = 4.8,
			en = 4.066
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
				arg_32_0:Play112201009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1039ui_story"]) and arg_32_1.var_.characterEffect1039ui_story == nil then
				arg_32_1.var_.characterEffect1039ui_story = arg_32_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1039ui_story"]) then
				if arg_32_1.var_.characterEffect1039ui_story and not isNil(arg_32_1.actors_["1039ui_story"]) then
					arg_32_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1039ui_story"]) and arg_32_1.var_.characterEffect1039ui_story then
				arg_32_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_35_1 = arg_32_1.actors_["1148ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1148ui_story == nil then
				arg_32_1.var_.characterEffect1148ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect1148ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1148ui_story then
				arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1148ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1148ui_story = var_35_4.localPosition
			end

			local var_35_5 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_32_1.time_ - 0) / var_35_5)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles
			end

			local var_35_6 = 0
			local var_35_7 = 0.5

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(112201008)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 20 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 20)

				if (20 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 20)) > 0 and var_35_7 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201008", "story_v_out_112201.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201008", "story_v_out_112201.awb") / 1000

					if var_35_12 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_6
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_out_112201", "112201008", "story_v_out_112201.awb")

						arg_32_1:RecordAudio("112201008", var_35_13)
						arg_32_1:RecordAudio("112201008", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_112201", "112201008", "story_v_out_112201.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_112201", "112201008", "story_v_out_112201.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play112201009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112201009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play112201010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148ui_story = arg_36_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).z)
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles = arg_36_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).z)
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles = arg_36_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1039ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1039ui_story = var_39_1.localPosition
			end

			local var_39_2 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_2)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, 100, 0)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			local var_39_3 = 0
			local var_39_4 = 0.8

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(112201009).content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 32 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_5) / 32)

				if (32 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_5) / 32)) > 0 and var_39_4 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_3
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_4, arg_36_1.talkMaxDuration)

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_3) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_3 + var_39_8 and arg_36_1.time_ < var_39_3 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play112201010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112201010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play112201011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.5

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(112201010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 20)

				if (20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 20)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play112201011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112201011
		arg_44_1.duration_ = 3.57

		local var_44_0 = {
			ja = 3.566,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play112201012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_47_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_44_1.stage_.transform)

				var_47_0.name = "1081ui_story"
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1081ui_story"] = var_47_0

				local var_47_1 = var_47_0:GetComponentInChildren(typeof(CharacterEffect))

				var_47_1.enabled = true

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_1.transform, false)

				arg_44_1.var_["1081ui_story" .. "Animator"] = var_47_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_44_1.var_["1081ui_story" .. "LipSync"] = var_47_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_3 = arg_44_1.actors_["1081ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1081ui_story = var_47_3.localPosition
			end

			local var_47_4 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				var_47_3.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_44_1.time_ - 0) / var_47_4)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				var_47_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_47_5 = arg_44_1.actors_["1081ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1081ui_story == nil then
				arg_44_1.var_.characterEffect1081ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_6 and not isNil(var_47_5) then
				if arg_44_1.var_.characterEffect1081ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_6 and arg_44_1.time_ < 0 + var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1081ui_story then
				arg_44_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_47_8 = 0
			local var_47_9 = 0.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:GetWordFromCfg(112201011)
				local var_47_11 = arg_44_1:FormatText(var_47_10.content)

				arg_44_1.text_.text = var_47_11

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_13 = 5 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 5)

				if (5 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 5)) > 0 and var_47_9 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_11
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201011", "story_v_out_112201.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_112201", "112201011", "story_v_out_112201.awb") / 1000

					if var_47_14 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_8
					end

					if var_47_10.prefab_name ~= "" and arg_44_1.actors_[var_47_10.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_10.prefab_name].transform, "story_v_out_112201", "112201011", "story_v_out_112201.awb")

						arg_44_1:RecordAudio("112201011", var_47_15)
						arg_44_1:RecordAudio("112201011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_112201", "112201011", "story_v_out_112201.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_112201", "112201011", "story_v_out_112201.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_16 and arg_44_1.time_ < var_47_8 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play112201012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 112201012
		arg_48_1.duration_ = 10.7

		local var_48_0 = {
			ja = 6.933,
			ko = 9.933,
			zh = 10.7,
			en = 9.066
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
				arg_48_0:Play112201013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_51_0 = 0
			local var_51_1 = 1

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(112201012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 40 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 40)

				if (40 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 40)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201012", "story_v_out_112201.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_112201", "112201012", "story_v_out_112201.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_112201", "112201012", "story_v_out_112201.awb")

						arg_48_1:RecordAudio("112201012", var_51_7)
						arg_48_1:RecordAudio("112201012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_112201", "112201012", "story_v_out_112201.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_112201", "112201012", "story_v_out_112201.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play112201013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 112201013
		arg_52_1.duration_ = 6.03

		local var_52_0 = {
			ja = 6.033,
			ko = 4,
			zh = 3.766,
			en = 4.2
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
				arg_52_0:Play112201014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_55_0 = 0
			local var_55_1 = 0.5

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(112201013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 20 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 20)

				if (20 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 20)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201013", "story_v_out_112201.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_112201", "112201013", "story_v_out_112201.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_112201", "112201013", "story_v_out_112201.awb")

						arg_52_1:RecordAudio("112201013", var_55_7)
						arg_52_1:RecordAudio("112201013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_112201", "112201013", "story_v_out_112201.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_112201", "112201013", "story_v_out_112201.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play112201014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 112201014
		arg_56_1.duration_ = 8.87

		local var_56_0 = {
			ja = 8.266,
			ko = 6.1,
			zh = 7.1,
			en = 8.866
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
				arg_56_0:Play112201015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1081ui_story = arg_56_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1081ui_story"].transform.position).z)
				arg_56_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1081ui_story"].transform.localEulerAngles = arg_56_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1081ui_story"].transform.position).z)
				arg_56_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1081ui_story"].transform.localEulerAngles = arg_56_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1039ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1039ui_story = var_59_1.localPosition
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_59_3 = arg_56_1.actors_["1039ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1039ui_story == nil then
				arg_56_1.var_.characterEffect1039ui_story = var_59_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_4 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 and not isNil(var_59_3) then
				if arg_56_1.var_.characterEffect1039ui_story and not isNil(var_59_3) then
					arg_56_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1039ui_story then
				arg_56_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_59_6 = 0
			local var_59_7 = 0.825

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(112201014)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 33 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 33)

				if (33 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 33)) > 0 and var_59_7 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201014", "story_v_out_112201.awb") ~= 0 then
					local var_59_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201014", "story_v_out_112201.awb") / 1000

					if var_59_12 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_6
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_112201", "112201014", "story_v_out_112201.awb")

						arg_56_1:RecordAudio("112201014", var_59_13)
						arg_56_1:RecordAudio("112201014", var_59_13)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_112201", "112201014", "story_v_out_112201.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_112201", "112201014", "story_v_out_112201.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play112201015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 112201015
		arg_60_1.duration_ = 6.73

		local var_60_0 = {
			ja = 6.733,
			ko = 6.7,
			zh = 4.3,
			en = 3.666
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
				arg_60_0:Play112201016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1039ui_story"]) and arg_60_1.var_.characterEffect1039ui_story == nil then
				arg_60_1.var_.characterEffect1039ui_story = arg_60_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1039ui_story"]) then
				if arg_60_1.var_.characterEffect1039ui_story and not isNil(arg_60_1.actors_["1039ui_story"]) then
					arg_60_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1039ui_story"]) and arg_60_1.var_.characterEffect1039ui_story then
				arg_60_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_63_1 = arg_60_1.actors_["1081ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1081ui_story = var_63_1.localPosition
			end

			local var_63_2 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 then
				var_63_1.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_60_1.time_ - 0) / var_63_2)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 then
				var_63_1.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_63_3 = arg_60_1.actors_["1081ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1081ui_story == nil then
				arg_60_1.var_.characterEffect1081ui_story = var_63_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_4 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 and not isNil(var_63_3) then
				if arg_60_1.var_.characterEffect1081ui_story and not isNil(var_63_3) then
					arg_60_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1081ui_story then
				arg_60_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_63_6 = 0
			local var_63_7 = 1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_8 = arg_60_1:GetWordFromCfg(112201015)
				local var_63_9 = arg_60_1:FormatText(var_63_8.content)

				arg_60_1.text_.text = var_63_9

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 23 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 23)

				if (23 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 23)) > 0 and var_63_7 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_9
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201015", "story_v_out_112201.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201015", "story_v_out_112201.awb") / 1000

					if var_63_12 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_6
					end

					if var_63_8.prefab_name ~= "" and arg_60_1.actors_[var_63_8.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_8.prefab_name].transform, "story_v_out_112201", "112201015", "story_v_out_112201.awb")

						arg_60_1:RecordAudio("112201015", var_63_13)
						arg_60_1:RecordAudio("112201015", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_112201", "112201015", "story_v_out_112201.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_112201", "112201015", "story_v_out_112201.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play112201016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112201016
		arg_64_1.duration_ = 8.13

		local var_64_0 = {
			ja = 6.066,
			ko = 7.5,
			zh = 8,
			en = 8.133
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
				arg_64_0:Play112201017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_67_0 = 0
			local var_67_1 = 0.75

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(112201016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 30 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 30)

				if (30 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 30)) > 0 and var_67_1 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201016", "story_v_out_112201.awb") ~= 0 then
					local var_67_6 = manager.audio:GetVoiceLength("story_v_out_112201", "112201016", "story_v_out_112201.awb") / 1000

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end

					if var_67_2.prefab_name ~= "" and arg_64_1.actors_[var_67_2.prefab_name] ~= nil then
						local var_67_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_2.prefab_name].transform, "story_v_out_112201", "112201016", "story_v_out_112201.awb")

						arg_64_1:RecordAudio("112201016", var_67_7)
						arg_64_1:RecordAudio("112201016", var_67_7)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_112201", "112201016", "story_v_out_112201.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_112201", "112201016", "story_v_out_112201.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play112201017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112201017
		arg_68_1.duration_ = 4.57

		local var_68_0 = {
			ja = 4.566,
			ko = 2.7,
			zh = 3.033,
			en = 3.766
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
				arg_68_0:Play112201018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_71_0 = 0
			local var_71_1 = 0.325

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(112201017)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 13 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 13)

				if (13 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 13)) > 0 and var_71_1 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201017", "story_v_out_112201.awb") ~= 0 then
					local var_71_6 = manager.audio:GetVoiceLength("story_v_out_112201", "112201017", "story_v_out_112201.awb") / 1000

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end

					if var_71_2.prefab_name ~= "" and arg_68_1.actors_[var_71_2.prefab_name] ~= nil then
						local var_71_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_2.prefab_name].transform, "story_v_out_112201", "112201017", "story_v_out_112201.awb")

						arg_68_1:RecordAudio("112201017", var_71_7)
						arg_68_1:RecordAudio("112201017", var_71_7)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_112201", "112201017", "story_v_out_112201.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_112201", "112201017", "story_v_out_112201.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play112201018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112201018
		arg_72_1.duration_ = 7.8

		local var_72_0 = {
			ja = 5.033,
			ko = 7.133,
			zh = 5.466,
			en = 7.8
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play112201019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_75_0 = 0
			local var_75_1 = 0.725

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(112201018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 29 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 29)

				if (29 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 29)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201018", "story_v_out_112201.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_112201", "112201018", "story_v_out_112201.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_112201", "112201018", "story_v_out_112201.awb")

						arg_72_1:RecordAudio("112201018", var_75_7)
						arg_72_1:RecordAudio("112201018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_112201", "112201018", "story_v_out_112201.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_112201", "112201018", "story_v_out_112201.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play112201019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112201019
		arg_76_1.duration_ = 4.63

		local var_76_0 = {
			ja = 4,
			ko = 3.2,
			zh = 3.7,
			en = 4.633
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play112201020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1081ui_story = arg_76_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).z)
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles = arg_76_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).z)
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles = arg_76_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_79_1 = arg_76_1.actors_["1148ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1148ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1148ui_story then
				arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1148ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1148ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			local var_79_6 = 0
			local var_79_7 = 0.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(112201019)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 15 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 15)

				if (15 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 15)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201019", "story_v_out_112201.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201019", "story_v_out_112201.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_112201", "112201019", "story_v_out_112201.awb")

						arg_76_1:RecordAudio("112201019", var_79_13)
						arg_76_1:RecordAudio("112201019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_112201", "112201019", "story_v_out_112201.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_112201", "112201019", "story_v_out_112201.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play112201020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112201020
		arg_80_1.duration_ = 11.57

		local var_80_0 = {
			ja = 10.8,
			ko = 7.633,
			zh = 8,
			en = 11.566
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112201021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1148ui_story"]) and arg_80_1.var_.characterEffect1148ui_story == nil then
				arg_80_1.var_.characterEffect1148ui_story = arg_80_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1148ui_story"]) then
				if arg_80_1.var_.characterEffect1148ui_story and not isNil(arg_80_1.actors_["1148ui_story"]) then
					arg_80_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1148ui_story"]) and arg_80_1.var_.characterEffect1148ui_story then
				arg_80_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_83_1 = arg_80_1.actors_["1039ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1039ui_story == nil then
				arg_80_1.var_.characterEffect1039ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect1039ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1039ui_story then
				arg_80_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action464")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_83_4 = 0
			local var_83_5 = 0.925

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(112201020)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 37 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 37)

				if (37 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 37)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201020", "story_v_out_112201.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_112201", "112201020", "story_v_out_112201.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_112201", "112201020", "story_v_out_112201.awb")

						arg_80_1:RecordAudio("112201020", var_83_11)
						arg_80_1:RecordAudio("112201020", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_112201", "112201020", "story_v_out_112201.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_112201", "112201020", "story_v_out_112201.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play112201021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112201021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play112201022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148ui_story = arg_84_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).z)
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles = arg_84_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).z)
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles = arg_84_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["1039ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1039ui_story = var_87_1.localPosition
			end

			local var_87_2 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 then
				var_87_1.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_2)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 then
				var_87_1.localPosition = Vector3.New(0, 100, 0)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			local var_87_3 = 0
			local var_87_4 = 0.375

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_3 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(112201021).content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 15 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 15)

				if (15 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 15)) > 0 and var_87_4 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_3 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_3
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_4, arg_84_1.talkMaxDuration)

			if var_87_3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_3 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_3) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_3 + var_87_8 and arg_84_1.time_ < var_87_3 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play112201022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112201022
		arg_88_1.duration_ = 5.37

		local var_88_0 = {
			ja = 3.566,
			ko = 3.933,
			zh = 3.333,
			en = 5.366
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play112201023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_91_0 = arg_88_1.actors_["1084ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_1 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 and not isNil(var_91_0) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_91_3 = arg_88_1.actors_["1084ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_3.localPosition
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_3.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_88_1.time_ - 0) / var_91_4)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			local var_91_5 = 0
			local var_91_6 = 0.3

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:GetWordFromCfg(112201022)
				local var_91_8 = arg_88_1:FormatText(var_91_7.content)

				arg_88_1.text_.text = var_91_8

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 12 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 12)

				if (12 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 12)) > 0 and var_91_6 < var_91_10 then
					arg_88_1.talkMaxDuration = var_91_10

					if var_91_10 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_8
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201022", "story_v_out_112201.awb") ~= 0 then
					local var_91_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201022", "story_v_out_112201.awb") / 1000

					if var_91_11 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_5
					end

					if var_91_7.prefab_name ~= "" and arg_88_1.actors_[var_91_7.prefab_name] ~= nil then
						local var_91_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_7.prefab_name].transform, "story_v_out_112201", "112201022", "story_v_out_112201.awb")

						arg_88_1:RecordAudio("112201022", var_91_12)
						arg_88_1:RecordAudio("112201022", var_91_12)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_112201", "112201022", "story_v_out_112201.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_112201", "112201022", "story_v_out_112201.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_13 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_13 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_13

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_13 and arg_88_1.time_ < var_91_5 + var_91_13 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play112201023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112201023
		arg_92_1.duration_ = 3.83

		local var_92_0 = {
			ja = 3.833,
			ko = 3,
			zh = 3.4,
			en = 3.366
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play112201024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_95_0 = arg_92_1.actors_["1148ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1148ui_story == nil then
				arg_92_1.var_.characterEffect1148ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_1 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 and not isNil(var_95_0) then
				if arg_92_1.var_.characterEffect1148ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1148ui_story then
				arg_92_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_95_3 = arg_92_1.actors_["1148ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1148ui_story = var_95_3.localPosition
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_92_1.time_ - 0) / var_95_4)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			local var_95_5 = arg_92_1.actors_["1084ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 and not isNil(var_95_5) then
				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_5) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_6)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_95_7 = 0
			local var_95_8 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_9 = arg_92_1:GetWordFromCfg(112201023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_12 = 9 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 9)

				if (9 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 9)) > 0 and var_95_8 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_7
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201023", "story_v_out_112201.awb") ~= 0 then
					local var_95_13 = manager.audio:GetVoiceLength("story_v_out_112201", "112201023", "story_v_out_112201.awb") / 1000

					if var_95_13 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_7
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_112201", "112201023", "story_v_out_112201.awb")

						arg_92_1:RecordAudio("112201023", var_95_14)
						arg_92_1:RecordAudio("112201023", var_95_14)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_112201", "112201023", "story_v_out_112201.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_112201", "112201023", "story_v_out_112201.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_8, arg_92_1.talkMaxDuration)

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_7) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_7 + var_95_15 and arg_92_1.time_ < var_95_7 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play112201024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112201024
		arg_96_1.duration_ = 8.3

		local var_96_0 = {
			ja = 8.3,
			ko = 7.3,
			zh = 6.566,
			en = 7.8
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play112201025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1039ui_story = arg_96_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1039ui_story"].transform.position).z)
				arg_96_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1039ui_story"].transform.localEulerAngles = arg_96_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				arg_96_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1039ui_story"].transform.position).z)
				arg_96_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1039ui_story"].transform.localEulerAngles = arg_96_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_99_1 = arg_96_1.actors_["1039ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1039ui_story == nil then
				arg_96_1.var_.characterEffect1039ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1039ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1039ui_story then
				arg_96_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1084ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1084ui_story = var_99_4.localPosition
			end

			local var_99_5 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_5 then
				var_99_4.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_5)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_5 and arg_96_1.time_ < 0 + var_99_5 + arg_99_0 then
				var_99_4.localPosition = Vector3.New(0, 100, 0)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles
			end

			local var_99_6 = 0
			local var_99_7 = 1

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(112201024)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 29 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_9) / 29)

				if (29 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_9) / 29)) > 0 and var_99_7 < var_99_11 then
					arg_96_1.talkMaxDuration = var_99_11

					if var_99_11 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201024", "story_v_out_112201.awb") ~= 0 then
					local var_99_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201024", "story_v_out_112201.awb") / 1000

					if var_99_12 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_6
					end

					if var_99_8.prefab_name ~= "" and arg_96_1.actors_[var_99_8.prefab_name] ~= nil then
						local var_99_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_8.prefab_name].transform, "story_v_out_112201", "112201024", "story_v_out_112201.awb")

						arg_96_1:RecordAudio("112201024", var_99_13)
						arg_96_1:RecordAudio("112201024", var_99_13)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_112201", "112201024", "story_v_out_112201.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_112201", "112201024", "story_v_out_112201.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play112201025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112201025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play112201026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1039ui_story = arg_100_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1039ui_story"].transform.position).z)
				arg_100_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1039ui_story"].transform.localEulerAngles = arg_100_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1039ui_story"].transform.position).z)
				arg_100_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1039ui_story"].transform.localEulerAngles = arg_100_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1148ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1148ui_story = var_103_1.localPosition
			end

			local var_103_2 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 then
				var_103_1.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_2)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 then
				var_103_1.localPosition = Vector3.New(0, 100, 0)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			local var_103_3 = 0
			local var_103_4 = 0.375

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_5 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(112201025).content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 15 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 15)

				if (15 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 15)) > 0 and var_103_4 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_8 and arg_100_1.time_ < var_103_3 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play112201026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112201026
		arg_104_1.duration_ = 7.73

		local var_104_0 = {
			ja = 7.1,
			ko = 6.866,
			zh = 5,
			en = 7.733
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play112201027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_107_0 = arg_104_1.actors_["1084ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_1 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 and not isNil(var_107_0) then
				if arg_104_1.var_.characterEffect1084ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story then
				arg_104_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_107_3 = arg_104_1.actors_["1084ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1084ui_story = var_107_3.localPosition
			end

			local var_107_4 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				var_107_3.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_104_1.time_ - 0) / var_107_4)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				var_107_3.localPosition = Vector3.New(0, -0.97, -6)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			local var_107_5 = 0
			local var_107_6 = 1

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_7 = arg_104_1:GetWordFromCfg(112201026)
				local var_107_8 = arg_104_1:FormatText(var_107_7.content)

				arg_104_1.text_.text = var_107_8

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 25 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_8) / 25)

				if (25 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_8) / 25)) > 0 and var_107_6 < var_107_10 then
					arg_104_1.talkMaxDuration = var_107_10

					if var_107_10 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_5
					end
				end

				arg_104_1.text_.text = var_107_8
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201026", "story_v_out_112201.awb") ~= 0 then
					local var_107_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201026", "story_v_out_112201.awb") / 1000

					if var_107_11 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_5
					end

					if var_107_7.prefab_name ~= "" and arg_104_1.actors_[var_107_7.prefab_name] ~= nil then
						local var_107_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_7.prefab_name].transform, "story_v_out_112201", "112201026", "story_v_out_112201.awb")

						arg_104_1:RecordAudio("112201026", var_107_12)
						arg_104_1:RecordAudio("112201026", var_107_12)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_112201", "112201026", "story_v_out_112201.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_112201", "112201026", "story_v_out_112201.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = math.max(var_107_6, arg_104_1.talkMaxDuration)

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_13 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_5) / var_107_13

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_5 + var_107_13 and arg_104_1.time_ < var_107_5 + var_107_13 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play112201027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112201027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play112201028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1084ui_story = arg_108_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).z)
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles = arg_108_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).z)
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles = arg_108_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_111_1 = 0
			local var_111_2 = 1

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(112201027).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 21 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 21)

				if (21 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 21)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play112201028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112201028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play112201029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 1

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(112201028).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 31 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 31)

				if (31 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 31)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play112201029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112201029
		arg_116_1.duration_ = 11.13

		local var_116_0 = {
			ja = 9.9,
			ko = 11.133,
			zh = 9.833,
			en = 9.8
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play112201030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if arg_116_1.bgs_.H03 == nil then
				local var_119_0 = Object.Instantiate(arg_116_1.paintGo_)

				var_119_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H03")
				var_119_0.name = "H03"
				var_119_0.transform.parent = arg_116_1.stage_.transform
				var_119_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.bgs_.H03 = var_119_0
			end

			if 2 < arg_116_1.time_ and arg_116_1.time_ <= 2 + arg_119_0 then
				local var_119_1 = arg_116_1.bgs_.H03

				arg_116_1.bgs_.H03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_119_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_2 = var_119_1:GetComponent("SpriteRenderer")

				if var_119_2 and var_119_2.sprite then
					local var_119_3 = 2 * (var_119_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_119_1.transform.localScale = Vector3.New(var_119_3 / var_119_2.sprite.bounds.size.y < var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x and var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x or var_119_3 / var_119_2.sprite.bounds.size.y, var_119_3 / var_119_2.sprite.bounds.size.y < var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x and var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x or var_119_3 / var_119_2.sprite.bounds.size.y, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "H03" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_119_4 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_5 = 2

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_5 then
				local var_119_6 = Color.New(0, 0, 0)

				var_119_6.a = Mathf.Lerp(0, 1, (arg_116_1.time_ - var_119_4) / var_119_5)
				arg_116_1.mask_.color = var_119_6
			end

			if arg_116_1.time_ >= var_119_4 + var_119_5 and arg_116_1.time_ < var_119_4 + var_119_5 + arg_119_0 then
				local var_119_7 = Color.New(0, 0, 0)

				var_119_7.a = 1
				arg_116_1.mask_.color = var_119_7
			end

			local var_119_8 = 2

			if 2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_9 = 2

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_9 then
				local var_119_10 = Color.New(0, 0, 0)

				var_119_10.a = Mathf.Lerp(1, 0, (arg_116_1.time_ - var_119_8) / var_119_9)
				arg_116_1.mask_.color = var_119_10
			end

			if arg_116_1.time_ >= var_119_8 + var_119_9 and arg_116_1.time_ < var_119_8 + var_119_9 + arg_119_0 then
				local var_119_11 = Color.New(0, 0, 0)

				arg_116_1.mask_.enabled = false
				var_119_11.a = 0
				arg_116_1.mask_.color = var_119_11
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_12 = 4
			local var_119_13 = 1

			if 4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_14 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_14:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_15 = arg_116_1:GetWordFromCfg(112201029)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_18 = 19 <= 0 and var_119_13 or var_119_13 * (utf8.len(var_119_16) / 19)

				if (19 <= 0 and var_119_13 or var_119_13 * (utf8.len(var_119_16) / 19)) > 0 and var_119_13 < var_119_18 then
					arg_116_1.talkMaxDuration = var_119_18
					var_119_12 = var_119_12 + 0.3

					if var_119_18 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_18 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201029", "story_v_out_112201.awb") ~= 0 then
					local var_119_19 = manager.audio:GetVoiceLength("story_v_out_112201", "112201029", "story_v_out_112201.awb") / 1000

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_112201", "112201029", "story_v_out_112201.awb")

						arg_116_1:RecordAudio("112201029", var_119_20)
						arg_116_1:RecordAudio("112201029", var_119_20)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_112201", "112201029", "story_v_out_112201.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_112201", "112201029", "story_v_out_112201.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_21 = var_119_12 + 0.3
			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_21) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_21 + var_119_22 and arg_116_1.time_ < var_119_21 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play112201030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 112201030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play112201031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.475

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(112201030).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 19 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 19)

				if (19 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 19)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play112201031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 112201031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play112201032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.2

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(112201031).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 8 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 8)

				if (8 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 8)) > 0 and var_129_0 < var_129_3 then
					arg_126_1.talkMaxDuration = var_129_3

					if var_129_3 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_3 + 0
					end
				end

				arg_126_1.text_.text = var_129_1
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_4 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_4

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play112201032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 112201032
		arg_130_1.duration_ = 3.17

		local var_130_0 = {
			ja = 2.6,
			ko = 2,
			zh = 1.999999999999,
			en = 3.166
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play112201033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_133_0 = arg_130_1.actors_["1148ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1148ui_story == nil then
				arg_130_1.var_.characterEffect1148ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_1 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 and not isNil(var_133_0) then
				if arg_130_1.var_.characterEffect1148ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1148ui_story then
				arg_130_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_133_3 = arg_130_1.actors_["1148ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1148ui_story = var_133_3.localPosition
			end

			local var_133_4 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				var_133_3.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_130_1.time_ - 0) / var_133_4)
				var_133_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_3.position).x, (manager.ui.mainCamera.transform.position - var_133_3.position).y, (manager.ui.mainCamera.transform.position - var_133_3.position).z)
				var_133_3.localEulerAngles.z = 0
				var_133_3.localEulerAngles.x = 0
				var_133_3.localEulerAngles = var_133_3.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				var_133_3.localPosition = Vector3.New(0, -0.8, -6.2)
				var_133_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_3.position).x, (manager.ui.mainCamera.transform.position - var_133_3.position).y, (manager.ui.mainCamera.transform.position - var_133_3.position).z)
				var_133_3.localEulerAngles.z = 0
				var_133_3.localEulerAngles.x = 0
				var_133_3.localEulerAngles = var_133_3.localEulerAngles
			end

			local var_133_5 = 0
			local var_133_6 = 0.175

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:GetWordFromCfg(112201032)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 7 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 7)

				if (7 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 7)) > 0 and var_133_6 < var_133_10 then
					arg_130_1.talkMaxDuration = var_133_10

					if var_133_10 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201032", "story_v_out_112201.awb") ~= 0 then
					local var_133_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201032", "story_v_out_112201.awb") / 1000

					if var_133_11 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_5
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_112201", "112201032", "story_v_out_112201.awb")

						arg_130_1:RecordAudio("112201032", var_133_12)
						arg_130_1:RecordAudio("112201032", var_133_12)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_112201", "112201032", "story_v_out_112201.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_112201", "112201032", "story_v_out_112201.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_13 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_13 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_13

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_13 and arg_130_1.time_ < var_133_5 + var_133_13 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play112201033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 112201033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play112201034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1148ui_story"]) and arg_134_1.var_.characterEffect1148ui_story == nil then
				arg_134_1.var_.characterEffect1148ui_story = arg_134_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1148ui_story"]) then
				if arg_134_1.var_.characterEffect1148ui_story and not isNil(arg_134_1.actors_["1148ui_story"]) then
					arg_134_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1148ui_story"]) and arg_134_1.var_.characterEffect1148ui_story then
				arg_134_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.275

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(112201033).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 11 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 11)

				if (11 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 11)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play112201034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 112201034
		arg_138_1.duration_ = 15.07

		local var_138_0 = {
			ja = 11.133,
			ko = 11.033,
			zh = 10.866,
			en = 15.066
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play112201035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_141_0 = arg_138_1.actors_["1148ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1148ui_story == nil then
				arg_138_1.var_.characterEffect1148ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_1 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 and not isNil(var_141_0) then
				if arg_138_1.var_.characterEffect1148ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1148ui_story then
				arg_138_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_141_3 = 0
			local var_141_4 = 1.15

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_5 = arg_138_1:GetWordFromCfg(112201034)
				local var_141_6 = arg_138_1:FormatText(var_141_5.content)

				arg_138_1.text_.text = var_141_6

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_8 = 46 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 46)

				if (46 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 46)) > 0 and var_141_4 < var_141_8 then
					arg_138_1.talkMaxDuration = var_141_8

					if var_141_8 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_3
					end
				end

				arg_138_1.text_.text = var_141_6
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201034", "story_v_out_112201.awb") ~= 0 then
					local var_141_9 = manager.audio:GetVoiceLength("story_v_out_112201", "112201034", "story_v_out_112201.awb") / 1000

					if var_141_9 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_3
					end

					if var_141_5.prefab_name ~= "" and arg_138_1.actors_[var_141_5.prefab_name] ~= nil then
						local var_141_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_5.prefab_name].transform, "story_v_out_112201", "112201034", "story_v_out_112201.awb")

						arg_138_1:RecordAudio("112201034", var_141_10)
						arg_138_1:RecordAudio("112201034", var_141_10)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_112201", "112201034", "story_v_out_112201.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_112201", "112201034", "story_v_out_112201.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_11 = math.max(var_141_4, arg_138_1.talkMaxDuration)

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_11 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_3) / var_141_11

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_3 + var_141_11 and arg_138_1.time_ < var_141_3 + var_141_11 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play112201035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 112201035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play112201036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1148ui_story"]) and arg_142_1.var_.characterEffect1148ui_story == nil then
				arg_142_1.var_.characterEffect1148ui_story = arg_142_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1148ui_story"]) then
				if arg_142_1.var_.characterEffect1148ui_story and not isNil(arg_142_1.actors_["1148ui_story"]) then
					arg_142_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1148ui_story"]) and arg_142_1.var_.characterEffect1148ui_story then
				arg_142_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 0.325

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(112201035).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 13 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 13)

				if (13 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 13)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play112201036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 112201036
		arg_146_1.duration_ = 7

		local var_146_0 = {
			ja = 5.566,
			ko = 5.6,
			zh = 7,
			en = 6.6
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play112201037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action464")
			end

			local var_149_0 = arg_146_1.actors_["1148ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1148ui_story == nil then
				arg_146_1.var_.characterEffect1148ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_1 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_1 and not isNil(var_149_0) then
				if arg_146_1.var_.characterEffect1148ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_1 and arg_146_1.time_ < 0 + var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1148ui_story then
				arg_146_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_149_3 = 0
			local var_149_4 = 0.55

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_3 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_5 = arg_146_1:GetWordFromCfg(112201036)
				local var_149_6 = arg_146_1:FormatText(var_149_5.content)

				arg_146_1.text_.text = var_149_6

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_8 = 22 <= 0 and var_149_4 or var_149_4 * (utf8.len(var_149_6) / 22)

				if (22 <= 0 and var_149_4 or var_149_4 * (utf8.len(var_149_6) / 22)) > 0 and var_149_4 < var_149_8 then
					arg_146_1.talkMaxDuration = var_149_8

					if var_149_8 + var_149_3 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_3
					end
				end

				arg_146_1.text_.text = var_149_6
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201036", "story_v_out_112201.awb") ~= 0 then
					local var_149_9 = manager.audio:GetVoiceLength("story_v_out_112201", "112201036", "story_v_out_112201.awb") / 1000

					if var_149_9 + var_149_3 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_3
					end

					if var_149_5.prefab_name ~= "" and arg_146_1.actors_[var_149_5.prefab_name] ~= nil then
						local var_149_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_5.prefab_name].transform, "story_v_out_112201", "112201036", "story_v_out_112201.awb")

						arg_146_1:RecordAudio("112201036", var_149_10)
						arg_146_1:RecordAudio("112201036", var_149_10)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_112201", "112201036", "story_v_out_112201.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_112201", "112201036", "story_v_out_112201.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_11 = math.max(var_149_4, arg_146_1.talkMaxDuration)

			if var_149_3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_3 + var_149_11 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_3) / var_149_11

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_3 + var_149_11 and arg_146_1.time_ < var_149_3 + var_149_11 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play112201037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 112201037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play112201038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1148ui_story = arg_150_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1148ui_story"].transform.position).z)
				arg_150_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1148ui_story"].transform.localEulerAngles = arg_150_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1148ui_story"].transform.position).z)
				arg_150_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1148ui_story"].transform.localEulerAngles = arg_150_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_153_1 = 0
			local var_153_2 = 0.675

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(112201037).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 27 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 27)

				if (27 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 27)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play112201038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 112201038
		arg_154_1.duration_ = 8

		local var_154_0 = {
			ja = 6.3,
			ko = 6.533,
			zh = 4.633,
			en = 8
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play112201039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_157_0 = arg_154_1.actors_["1148ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1148ui_story == nil then
				arg_154_1.var_.characterEffect1148ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_1 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_1 and not isNil(var_157_0) then
				if arg_154_1.var_.characterEffect1148ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_1 and arg_154_1.time_ < 0 + var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1148ui_story then
				arg_154_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_157_3 = arg_154_1.actors_["1148ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1148ui_story = var_157_3.localPosition
			end

			local var_157_4 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				var_157_3.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_154_1.time_ - 0) / var_157_4)
				var_157_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_3.position).x, (manager.ui.mainCamera.transform.position - var_157_3.position).y, (manager.ui.mainCamera.transform.position - var_157_3.position).z)
				var_157_3.localEulerAngles.z = 0
				var_157_3.localEulerAngles.x = 0
				var_157_3.localEulerAngles = var_157_3.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				var_157_3.localPosition = Vector3.New(0, -0.8, -6.2)
				var_157_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_3.position).x, (manager.ui.mainCamera.transform.position - var_157_3.position).y, (manager.ui.mainCamera.transform.position - var_157_3.position).z)
				var_157_3.localEulerAngles.z = 0
				var_157_3.localEulerAngles.x = 0
				var_157_3.localEulerAngles = var_157_3.localEulerAngles
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action449")
			end

			local var_157_5 = 0
			local var_157_6 = 0.575

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_7 = arg_154_1:GetWordFromCfg(112201038)
				local var_157_8 = arg_154_1:FormatText(var_157_7.content)

				arg_154_1.text_.text = var_157_8

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 23 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 23)

				if (23 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 23)) > 0 and var_157_6 < var_157_10 then
					arg_154_1.talkMaxDuration = var_157_10

					if var_157_10 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_5
					end
				end

				arg_154_1.text_.text = var_157_8
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201038", "story_v_out_112201.awb") ~= 0 then
					local var_157_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201038", "story_v_out_112201.awb") / 1000

					if var_157_11 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_5
					end

					if var_157_7.prefab_name ~= "" and arg_154_1.actors_[var_157_7.prefab_name] ~= nil then
						local var_157_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_7.prefab_name].transform, "story_v_out_112201", "112201038", "story_v_out_112201.awb")

						arg_154_1:RecordAudio("112201038", var_157_12)
						arg_154_1:RecordAudio("112201038", var_157_12)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_112201", "112201038", "story_v_out_112201.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_112201", "112201038", "story_v_out_112201.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_13 = math.max(var_157_6, arg_154_1.talkMaxDuration)

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_13 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_5) / var_157_13

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_5 + var_157_13 and arg_154_1.time_ < var_157_5 + var_157_13 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play112201039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 112201039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play112201040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1148ui_story"]) and arg_158_1.var_.characterEffect1148ui_story == nil then
				arg_158_1.var_.characterEffect1148ui_story = arg_158_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1148ui_story"]) then
				if arg_158_1.var_.characterEffect1148ui_story and not isNil(arg_158_1.actors_["1148ui_story"]) then
					arg_158_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1148ui_story"]) and arg_158_1.var_.characterEffect1148ui_story then
				arg_158_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 0.225

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(112201039).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 9 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 9)

				if (9 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 9)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play112201040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 112201040
		arg_162_1.duration_ = 4.4

		local var_162_0 = {
			ja = 3.766,
			ko = 4.4,
			zh = 3.4,
			en = 2.633
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play112201041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1148ui_story = arg_162_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1148ui_story"].transform.position).z)
				arg_162_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1148ui_story"].transform.localEulerAngles = arg_162_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_162_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1148ui_story"].transform.position).z)
				arg_162_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1148ui_story"].transform.localEulerAngles = arg_162_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_165_1 = 0
			local var_165_2 = 0.3

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(112201040)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 12 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 12)

				if (12 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 12)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201040", "story_v_out_112201.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_112201", "112201040", "story_v_out_112201.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_112201", "112201040", "story_v_out_112201.awb")

						arg_162_1:RecordAudio("112201040", var_165_8)
						arg_162_1:RecordAudio("112201040", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_112201", "112201040", "story_v_out_112201.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_112201", "112201040", "story_v_out_112201.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play112201041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 112201041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play112201042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 1

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(112201041).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 45 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 45)

				if (45 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 45)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play112201042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 112201042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play112201043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.05

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(112201042).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 2 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 2)

				if (2 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 2)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play112201043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 112201043
		arg_174_1.duration_ = 6.6

		local var_174_0 = {
			ja = 3.7,
			ko = 4.1,
			zh = 4.3,
			en = 6.6
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play112201044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_177_0 = arg_174_1.actors_["1148ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1148ui_story == nil then
				arg_174_1.var_.characterEffect1148ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_1 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 and not isNil(var_177_0) then
				if arg_174_1.var_.characterEffect1148ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1148ui_story then
				arg_174_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_177_3 = arg_174_1.actors_["1148ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1148ui_story = var_177_3.localPosition
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_3.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_174_1.time_ - 0) / var_177_4)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_3.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles
			end

			local var_177_5 = 0
			local var_177_6 = 0.425

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:GetWordFromCfg(112201043)
				local var_177_8 = arg_174_1:FormatText(var_177_7.content)

				arg_174_1.text_.text = var_177_8

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_10 = 17 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 17)

				if (17 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 17)) > 0 and var_177_6 < var_177_10 then
					arg_174_1.talkMaxDuration = var_177_10

					if var_177_10 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_5
					end
				end

				arg_174_1.text_.text = var_177_8
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201043", "story_v_out_112201.awb") ~= 0 then
					local var_177_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201043", "story_v_out_112201.awb") / 1000

					if var_177_11 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_5
					end

					if var_177_7.prefab_name ~= "" and arg_174_1.actors_[var_177_7.prefab_name] ~= nil then
						local var_177_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_7.prefab_name].transform, "story_v_out_112201", "112201043", "story_v_out_112201.awb")

						arg_174_1:RecordAudio("112201043", var_177_12)
						arg_174_1:RecordAudio("112201043", var_177_12)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_112201", "112201043", "story_v_out_112201.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_112201", "112201043", "story_v_out_112201.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_6, arg_174_1.talkMaxDuration)

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_5) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_5 + var_177_13 and arg_174_1.time_ < var_177_5 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play112201044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 112201044
		arg_178_1.duration_ = 5.5

		local var_178_0 = {
			ja = 4.166,
			ko = 5.5,
			zh = 4.6,
			en = 3.4
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play112201045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1148ui_story"]) and arg_178_1.var_.characterEffect1148ui_story == nil then
				arg_178_1.var_.characterEffect1148ui_story = arg_178_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1148ui_story"]) then
				if arg_178_1.var_.characterEffect1148ui_story and not isNil(arg_178_1.actors_["1148ui_story"]) then
					arg_178_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1148ui_story"]) and arg_178_1.var_.characterEffect1148ui_story then
				arg_178_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_181_1 = arg_178_1.actors_["1084ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1084ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_181_4 = arg_178_1.actors_["1084ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1084ui_story = var_181_4.localPosition
			end

			local var_181_5 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_5 then
				var_181_4.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_178_1.time_ - 0) / var_181_5)
				var_181_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_4.position).x, (manager.ui.mainCamera.transform.position - var_181_4.position).y, (manager.ui.mainCamera.transform.position - var_181_4.position).z)
				var_181_4.localEulerAngles.z = 0
				var_181_4.localEulerAngles.x = 0
				var_181_4.localEulerAngles = var_181_4.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_5 and arg_178_1.time_ < 0 + var_181_5 + arg_181_0 then
				var_181_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_181_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_4.position).x, (manager.ui.mainCamera.transform.position - var_181_4.position).y, (manager.ui.mainCamera.transform.position - var_181_4.position).z)
				var_181_4.localEulerAngles.z = 0
				var_181_4.localEulerAngles.x = 0
				var_181_4.localEulerAngles = var_181_4.localEulerAngles
			end

			local var_181_6 = 0
			local var_181_7 = 0.375

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(112201044)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 15 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 15)

				if (15 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 15)) > 0 and var_181_7 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201044", "story_v_out_112201.awb") ~= 0 then
					local var_181_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201044", "story_v_out_112201.awb") / 1000

					if var_181_12 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_6
					end

					if var_181_8.prefab_name ~= "" and arg_178_1.actors_[var_181_8.prefab_name] ~= nil then
						local var_181_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_8.prefab_name].transform, "story_v_out_112201", "112201044", "story_v_out_112201.awb")

						arg_178_1:RecordAudio("112201044", var_181_13)
						arg_178_1:RecordAudio("112201044", var_181_13)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_112201", "112201044", "story_v_out_112201.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_112201", "112201044", "story_v_out_112201.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_14 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_14 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_14

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_14 and arg_178_1.time_ < var_181_6 + var_181_14 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play112201045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 112201045
		arg_182_1.duration_ = 6.83

		local var_182_0 = {
			ja = 5.3,
			ko = 4.6,
			zh = 3.966,
			en = 6.833
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play112201046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = arg_182_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) then
				if arg_182_1.var_.characterEffect1084ui_story and not isNil(arg_182_1.actors_["1084ui_story"]) then
					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story then
				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action449")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_185_1 = arg_182_1.actors_["1148ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1148ui_story = var_185_1.localPosition
			end

			local var_185_2 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 then
				var_185_1.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_182_1.time_ - 0) / var_185_2)
				var_185_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_1.position).x, (manager.ui.mainCamera.transform.position - var_185_1.position).y, (manager.ui.mainCamera.transform.position - var_185_1.position).z)
				var_185_1.localEulerAngles.z = 0
				var_185_1.localEulerAngles.x = 0
				var_185_1.localEulerAngles = var_185_1.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 then
				var_185_1.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_185_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_1.position).x, (manager.ui.mainCamera.transform.position - var_185_1.position).y, (manager.ui.mainCamera.transform.position - var_185_1.position).z)
				var_185_1.localEulerAngles.z = 0
				var_185_1.localEulerAngles.x = 0
				var_185_1.localEulerAngles = var_185_1.localEulerAngles
			end

			local var_185_3 = arg_182_1.actors_["1148ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_3) and arg_182_1.var_.characterEffect1148ui_story == nil then
				arg_182_1.var_.characterEffect1148ui_story = var_185_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_4 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 and not isNil(var_185_3) then
				if arg_182_1.var_.characterEffect1148ui_story and not isNil(var_185_3) then
					arg_182_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 and not isNil(var_185_3) and arg_182_1.var_.characterEffect1148ui_story then
				arg_182_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_185_6 = 0
			local var_185_7 = 0.475

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_8 = arg_182_1:GetWordFromCfg(112201045)
				local var_185_9 = arg_182_1:FormatText(var_185_8.content)

				arg_182_1.text_.text = var_185_9

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 19 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_9) / 19)

				if (19 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_9) / 19)) > 0 and var_185_7 < var_185_11 then
					arg_182_1.talkMaxDuration = var_185_11

					if var_185_11 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_9
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201045", "story_v_out_112201.awb") ~= 0 then
					local var_185_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201045", "story_v_out_112201.awb") / 1000

					if var_185_12 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_12 + var_185_6
					end

					if var_185_8.prefab_name ~= "" and arg_182_1.actors_[var_185_8.prefab_name] ~= nil then
						local var_185_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_8.prefab_name].transform, "story_v_out_112201", "112201045", "story_v_out_112201.awb")

						arg_182_1:RecordAudio("112201045", var_185_13)
						arg_182_1:RecordAudio("112201045", var_185_13)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_112201", "112201045", "story_v_out_112201.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_112201", "112201045", "story_v_out_112201.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_14 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_14 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_14

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_14 and arg_182_1.time_ < var_185_6 + var_185_14 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play112201046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 112201046
		arg_186_1.duration_ = 0.2

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"

			SetActive(arg_186_1.choicesGo_, true)

			for iter_187_0, iter_187_1 in ipairs(arg_186_1.choices_) do
				SetActive(iter_187_1.go, iter_187_0 <= 2)
			end

			arg_186_1.choices_[1].txt.text = arg_186_1:FormatText(StoryChoiceCfg[131].name)
			arg_186_1.choices_[2].txt.text = arg_186_1:FormatText(StoryChoiceCfg[132].name)
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play112201047(arg_186_1)
			end

			if arg_188_0 == 2 then
				arg_186_0:Play112201049(arg_186_1)
			end

			arg_186_1:RecordChoiceLog(112201046, 131, 132)
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1148ui_story"]) and arg_186_1.var_.characterEffect1148ui_story == nil then
				arg_186_1.var_.characterEffect1148ui_story = arg_186_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1148ui_story"]) then
				if arg_186_1.var_.characterEffect1148ui_story and not isNil(arg_186_1.actors_["1148ui_story"]) then
					arg_186_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1148ui_story"]) and arg_186_1.var_.characterEffect1148ui_story then
				arg_186_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play112201047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 112201047
		arg_190_1.duration_ = 3.93

		local var_190_0 = {
			ja = 2.566,
			ko = 3.933,
			zh = 3.3,
			en = 2.733
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play112201048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_193_0 = arg_190_1.actors_["1084ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1084ui_story == nil then
				arg_190_1.var_.characterEffect1084ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_1 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_1 and not isNil(var_193_0) then
				if arg_190_1.var_.characterEffect1084ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_1 and arg_190_1.time_ < 0 + var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1084ui_story then
				arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_193_3 = 0
			local var_193_4 = 0.4

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_3 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_5 = arg_190_1:GetWordFromCfg(112201047)
				local var_193_6 = arg_190_1:FormatText(var_193_5.content)

				arg_190_1.text_.text = var_193_6

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_8 = 16 <= 0 and var_193_4 or var_193_4 * (utf8.len(var_193_6) / 16)

				if (16 <= 0 and var_193_4 or var_193_4 * (utf8.len(var_193_6) / 16)) > 0 and var_193_4 < var_193_8 then
					arg_190_1.talkMaxDuration = var_193_8

					if var_193_8 + var_193_3 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_3
					end
				end

				arg_190_1.text_.text = var_193_6
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201047", "story_v_out_112201.awb") ~= 0 then
					local var_193_9 = manager.audio:GetVoiceLength("story_v_out_112201", "112201047", "story_v_out_112201.awb") / 1000

					if var_193_9 + var_193_3 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_3
					end

					if var_193_5.prefab_name ~= "" and arg_190_1.actors_[var_193_5.prefab_name] ~= nil then
						local var_193_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_5.prefab_name].transform, "story_v_out_112201", "112201047", "story_v_out_112201.awb")

						arg_190_1:RecordAudio("112201047", var_193_10)
						arg_190_1:RecordAudio("112201047", var_193_10)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_112201", "112201047", "story_v_out_112201.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_112201", "112201047", "story_v_out_112201.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_11 = math.max(var_193_4, arg_190_1.talkMaxDuration)

			if var_193_3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_3 + var_193_11 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_3) / var_193_11

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_3 + var_193_11 and arg_190_1.time_ < var_193_3 + var_193_11 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play112201048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 112201048
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play112201052(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story == nil then
				arg_194_1.var_.characterEffect1084ui_story = arg_194_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) then
				if arg_194_1.var_.characterEffect1084ui_story and not isNil(arg_194_1.actors_["1084ui_story"]) then
					arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story then
				arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.2

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(112201048).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 8 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 8)

				if (8 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 8)) > 0 and var_197_2 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_6 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_6 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_6

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_6 and arg_194_1.time_ < var_197_1 + var_197_6 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play112201052 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 112201052
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play112201053(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.525

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_1 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(112201052).content)

				arg_198_1.text_.text = var_201_1

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_3 = 21 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 21)

				if (21 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 21)) > 0 and var_201_0 < var_201_3 then
					arg_198_1.talkMaxDuration = var_201_3

					if var_201_3 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_3 + 0
					end
				end

				arg_198_1.text_.text = var_201_1
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_4 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_4

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play112201053 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 112201053
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play112201054(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1148ui_story = arg_202_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1148ui_story"].transform.position).z)
				arg_202_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1148ui_story"].transform.localEulerAngles = arg_202_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1148ui_story"].transform.position).z)
				arg_202_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1148ui_story"].transform.localEulerAngles = arg_202_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1084ui_story"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1084ui_story = var_205_1.localPosition
			end

			local var_205_2 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 then
				var_205_1.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_2)
				var_205_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_1.position).x, (manager.ui.mainCamera.transform.position - var_205_1.position).y, (manager.ui.mainCamera.transform.position - var_205_1.position).z)
				var_205_1.localEulerAngles.z = 0
				var_205_1.localEulerAngles.x = 0
				var_205_1.localEulerAngles = var_205_1.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 then
				var_205_1.localPosition = Vector3.New(0, 100, 0)
				var_205_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_1.position).x, (manager.ui.mainCamera.transform.position - var_205_1.position).y, (manager.ui.mainCamera.transform.position - var_205_1.position).z)
				var_205_1.localEulerAngles.z = 0
				var_205_1.localEulerAngles.x = 0
				var_205_1.localEulerAngles = var_205_1.localEulerAngles
			end

			local var_205_3 = 0
			local var_205_4 = 1.025

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_5 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(112201053).content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 41 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 41)

				if (41 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 41)) > 0 and var_205_4 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_8 and arg_202_1.time_ < var_205_3 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play112201054 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 112201054
		arg_206_1.duration_ = 6.47

		local var_206_0 = {
			ja = 3.233,
			ko = 6.466,
			zh = 5.8,
			en = 5.6
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play112201055(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1039ui_story = arg_206_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1039ui_story"].transform.position).z)
				arg_206_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1039ui_story"].transform.localEulerAngles = arg_206_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_206_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1039ui_story"].transform.position).z)
				arg_206_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1039ui_story"].transform.localEulerAngles = arg_206_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_209_1 = arg_206_1.actors_["1039ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1039ui_story == nil then
				arg_206_1.var_.characterEffect1039ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect1039ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1039ui_story then
				arg_206_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_209_4 = 0
			local var_209_5 = 0.55

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:GetWordFromCfg(112201054)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 22 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 22)

				if (22 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 22)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201054", "story_v_out_112201.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_out_112201", "112201054", "story_v_out_112201.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_out_112201", "112201054", "story_v_out_112201.awb")

						arg_206_1:RecordAudio("112201054", var_209_11)
						arg_206_1:RecordAudio("112201054", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_112201", "112201054", "story_v_out_112201.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_112201", "112201054", "story_v_out_112201.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_12 and arg_206_1.time_ < var_209_4 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play112201055 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 112201055
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play112201056(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1039ui_story"]) and arg_210_1.var_.characterEffect1039ui_story == nil then
				arg_210_1.var_.characterEffect1039ui_story = arg_210_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1039ui_story"]) then
				if arg_210_1.var_.characterEffect1039ui_story and not isNil(arg_210_1.actors_["1039ui_story"]) then
					arg_210_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1039ui_story"]) and arg_210_1.var_.characterEffect1039ui_story then
				arg_210_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_213_1 = 0
			local var_213_2 = 0.725

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(112201055).content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 29 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 29)

				if (29 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 29)) > 0 and var_213_2 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_6 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_6 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_6

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_6 and arg_210_1.time_ < var_213_1 + var_213_6 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play112201056 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 112201056
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play112201057(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1039ui_story = arg_214_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1039ui_story"].transform.position).z)
				arg_214_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1039ui_story"].transform.localEulerAngles = arg_214_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1039ui_story"].transform.position).z)
				arg_214_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1039ui_story"].transform.localEulerAngles = arg_214_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_217_1 = 0
			local var_217_2 = 1.25

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(112201056).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 50 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 50)

				if (50 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 50)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play112201057 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 112201057
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play112201058(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.475

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(112201057).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 19 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 19)

				if (19 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 19)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play112201058 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 112201058
		arg_222_1.duration_ = 3.23

		local var_222_0 = {
			ja = 2.933,
			ko = 3.233,
			zh = 2.333,
			en = 1.999999999999
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play112201059(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_225_0 = arg_222_1.actors_["1084ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1084ui_story == nil then
				arg_222_1.var_.characterEffect1084ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_1 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_1 and not isNil(var_225_0) then
				if arg_222_1.var_.characterEffect1084ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_1 and arg_222_1.time_ < 0 + var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1084ui_story then
				arg_222_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_225_3 = arg_222_1.actors_["1084ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1084ui_story = var_225_3.localPosition
			end

			local var_225_4 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				var_225_3.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_222_1.time_ - 0) / var_225_4)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				var_225_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles
			end

			local var_225_5 = 0
			local var_225_6 = 0.225

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_7 = arg_222_1:GetWordFromCfg(112201058)
				local var_225_8 = arg_222_1:FormatText(var_225_7.content)

				arg_222_1.text_.text = var_225_8

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 9 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 9)

				if (9 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 9)) > 0 and var_225_6 < var_225_10 then
					arg_222_1.talkMaxDuration = var_225_10

					if var_225_10 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_8
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201058", "story_v_out_112201.awb") ~= 0 then
					local var_225_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201058", "story_v_out_112201.awb") / 1000

					if var_225_11 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_5
					end

					if var_225_7.prefab_name ~= "" and arg_222_1.actors_[var_225_7.prefab_name] ~= nil then
						local var_225_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_7.prefab_name].transform, "story_v_out_112201", "112201058", "story_v_out_112201.awb")

						arg_222_1:RecordAudio("112201058", var_225_12)
						arg_222_1:RecordAudio("112201058", var_225_12)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_112201", "112201058", "story_v_out_112201.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_112201", "112201058", "story_v_out_112201.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_13 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_13

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_13 and arg_222_1.time_ < var_225_5 + var_225_13 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play112201059 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 112201059
		arg_226_1.duration_ = 5.33

		local var_226_0 = {
			ja = 3.033,
			ko = 4.266,
			zh = 5.233,
			en = 5.333
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play112201060(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_229_0 = arg_226_1.actors_["1148ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1148ui_story == nil then
				arg_226_1.var_.characterEffect1148ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_1 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 and not isNil(var_229_0) then
				if arg_226_1.var_.characterEffect1148ui_story and not isNil(var_229_0) then
					arg_226_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1148ui_story then
				arg_226_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_229_3 = arg_226_1.actors_["1148ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1148ui_story = var_229_3.localPosition
			end

			local var_229_4 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				var_229_3.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_226_1.time_ - 0) / var_229_4)
				var_229_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_3.position).x, (manager.ui.mainCamera.transform.position - var_229_3.position).y, (manager.ui.mainCamera.transform.position - var_229_3.position).z)
				var_229_3.localEulerAngles.z = 0
				var_229_3.localEulerAngles.x = 0
				var_229_3.localEulerAngles = var_229_3.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				var_229_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_229_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_3.position).x, (manager.ui.mainCamera.transform.position - var_229_3.position).y, (manager.ui.mainCamera.transform.position - var_229_3.position).z)
				var_229_3.localEulerAngles.z = 0
				var_229_3.localEulerAngles.x = 0
				var_229_3.localEulerAngles = var_229_3.localEulerAngles
			end

			local var_229_5 = 0
			local var_229_6 = 0.525

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_7 = arg_226_1:GetWordFromCfg(112201059)
				local var_229_8 = arg_226_1:FormatText(var_229_7.content)

				arg_226_1.text_.text = var_229_8

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_10 = 21 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 21)

				if (21 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 21)) > 0 and var_229_6 < var_229_10 then
					arg_226_1.talkMaxDuration = var_229_10

					if var_229_10 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_8
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201059", "story_v_out_112201.awb") ~= 0 then
					local var_229_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201059", "story_v_out_112201.awb") / 1000

					if var_229_11 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_5
					end

					if var_229_7.prefab_name ~= "" and arg_226_1.actors_[var_229_7.prefab_name] ~= nil then
						local var_229_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_7.prefab_name].transform, "story_v_out_112201", "112201059", "story_v_out_112201.awb")

						arg_226_1:RecordAudio("112201059", var_229_12)
						arg_226_1:RecordAudio("112201059", var_229_12)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_112201", "112201059", "story_v_out_112201.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_112201", "112201059", "story_v_out_112201.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_13 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_13 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_13

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_13 and arg_226_1.time_ < var_229_5 + var_229_13 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play112201060 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 112201060
		arg_230_1.duration_ = 5.47

		local var_230_0 = {
			ja = 5.466,
			ko = 4.466,
			zh = 5.333,
			en = 4.633
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play112201061(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1148ui_story = arg_230_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1148ui_story"].transform.position).z)
				arg_230_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1148ui_story"].transform.localEulerAngles = arg_230_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1148ui_story"].transform.position).z)
				arg_230_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1148ui_story"].transform.localEulerAngles = arg_230_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1084ui_story"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1084ui_story = var_233_1.localPosition
			end

			local var_233_2 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 then
				var_233_1.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_2)
				var_233_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_1.position).x, (manager.ui.mainCamera.transform.position - var_233_1.position).y, (manager.ui.mainCamera.transform.position - var_233_1.position).z)
				var_233_1.localEulerAngles.z = 0
				var_233_1.localEulerAngles.x = 0
				var_233_1.localEulerAngles = var_233_1.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 then
				var_233_1.localPosition = Vector3.New(0, 100, 0)
				var_233_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_1.position).x, (manager.ui.mainCamera.transform.position - var_233_1.position).y, (manager.ui.mainCamera.transform.position - var_233_1.position).z)
				var_233_1.localEulerAngles.z = 0
				var_233_1.localEulerAngles.x = 0
				var_233_1.localEulerAngles = var_233_1.localEulerAngles
			end

			local var_233_3 = arg_230_1.actors_["1039ui_story"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1039ui_story = var_233_3.localPosition
			end

			local var_233_4 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				var_233_3.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_230_1.time_ - 0) / var_233_4)
				var_233_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_3.position).x, (manager.ui.mainCamera.transform.position - var_233_3.position).y, (manager.ui.mainCamera.transform.position - var_233_3.position).z)
				var_233_3.localEulerAngles.z = 0
				var_233_3.localEulerAngles.x = 0
				var_233_3.localEulerAngles = var_233_3.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				var_233_3.localPosition = Vector3.New(0, -1.01, -5.9)
				var_233_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_3.position).x, (manager.ui.mainCamera.transform.position - var_233_3.position).y, (manager.ui.mainCamera.transform.position - var_233_3.position).z)
				var_233_3.localEulerAngles.z = 0
				var_233_3.localEulerAngles.x = 0
				var_233_3.localEulerAngles = var_233_3.localEulerAngles
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_233_5 = arg_230_1.actors_["1039ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_5) and arg_230_1.var_.characterEffect1039ui_story == nil then
				arg_230_1.var_.characterEffect1039ui_story = var_233_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_6 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_6 and not isNil(var_233_5) then
				if arg_230_1.var_.characterEffect1039ui_story and not isNil(var_233_5) then
					arg_230_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_6 and arg_230_1.time_ < 0 + var_233_6 + arg_233_0 and not isNil(var_233_5) and arg_230_1.var_.characterEffect1039ui_story then
				arg_230_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_233_8 = 0
			local var_233_9 = 0.45

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_10 = arg_230_1:GetWordFromCfg(112201060)
				local var_233_11 = arg_230_1:FormatText(var_233_10.content)

				arg_230_1.text_.text = var_233_11

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 18 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 18)

				if (18 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 18)) > 0 and var_233_9 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_11
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201060", "story_v_out_112201.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_112201", "112201060", "story_v_out_112201.awb") / 1000

					if var_233_14 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_8
					end

					if var_233_10.prefab_name ~= "" and arg_230_1.actors_[var_233_10.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_10.prefab_name].transform, "story_v_out_112201", "112201060", "story_v_out_112201.awb")

						arg_230_1:RecordAudio("112201060", var_233_15)
						arg_230_1:RecordAudio("112201060", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_112201", "112201060", "story_v_out_112201.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_112201", "112201060", "story_v_out_112201.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_16 and arg_230_1.time_ < var_233_8 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play112201061 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 112201061
		arg_234_1.duration_ = 11.83

		local var_234_0 = {
			ja = 11.833,
			ko = 5.6,
			zh = 7.166,
			en = 9.533
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play112201062(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_237_0 = 0
			local var_237_1 = 0.7

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_2 = arg_234_1:GetWordFromCfg(112201061)
				local var_237_3 = arg_234_1:FormatText(var_237_2.content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 28 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 28)

				if (28 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 28)) > 0 and var_237_1 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201061", "story_v_out_112201.awb") ~= 0 then
					local var_237_6 = manager.audio:GetVoiceLength("story_v_out_112201", "112201061", "story_v_out_112201.awb") / 1000

					if var_237_6 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_0
					end

					if var_237_2.prefab_name ~= "" and arg_234_1.actors_[var_237_2.prefab_name] ~= nil then
						local var_237_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_2.prefab_name].transform, "story_v_out_112201", "112201061", "story_v_out_112201.awb")

						arg_234_1:RecordAudio("112201061", var_237_7)
						arg_234_1:RecordAudio("112201061", var_237_7)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_112201", "112201061", "story_v_out_112201.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_112201", "112201061", "story_v_out_112201.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_8 and arg_234_1.time_ < var_237_0 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play112201062 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 112201062
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play112201063(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1039ui_story"]) and arg_238_1.var_.characterEffect1039ui_story == nil then
				arg_238_1.var_.characterEffect1039ui_story = arg_238_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1039ui_story"]) then
				if arg_238_1.var_.characterEffect1039ui_story and not isNil(arg_238_1.actors_["1039ui_story"]) then
					arg_238_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1039ui_story"]) and arg_238_1.var_.characterEffect1039ui_story then
				arg_238_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.125

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(112201062).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 5 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 5)

				if (5 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 5)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play112201063 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 112201063
		arg_242_1.duration_ = 3.87

		local var_242_0 = {
			ja = 2.9,
			ko = 3.866,
			zh = 2.4,
			en = 2.266
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play112201064(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.175

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_1 = arg_242_1:GetWordFromCfg(112201063)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 7 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 7)

				if (7 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 7)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201063", "story_v_out_112201.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_112201", "112201063", "story_v_out_112201.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_112201", "112201063", "story_v_out_112201.awb")

						arg_242_1:RecordAudio("112201063", var_245_6)
						arg_242_1:RecordAudio("112201063", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_112201", "112201063", "story_v_out_112201.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_112201", "112201063", "story_v_out_112201.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play112201064 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 112201064
		arg_246_1.duration_ = 3.57

		local var_246_0 = {
			ja = 3.566,
			ko = 2.333,
			zh = 2.6,
			en = 1.999999999999
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play112201065(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_249_0 = arg_246_1.actors_["1039ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1039ui_story == nil then
				arg_246_1.var_.characterEffect1039ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_1 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 and not isNil(var_249_0) then
				if arg_246_1.var_.characterEffect1039ui_story and not isNil(var_249_0) then
					arg_246_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1039ui_story then
				arg_246_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_249_3 = 0
			local var_249_4 = 0.2

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_3 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_5 = arg_246_1:GetWordFromCfg(112201064)
				local var_249_6 = arg_246_1:FormatText(var_249_5.content)

				arg_246_1.text_.text = var_249_6

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_8 = 8 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_6) / 8)

				if (8 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_6) / 8)) > 0 and var_249_4 < var_249_8 then
					arg_246_1.talkMaxDuration = var_249_8

					if var_249_8 + var_249_3 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_3
					end
				end

				arg_246_1.text_.text = var_249_6
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201064", "story_v_out_112201.awb") ~= 0 then
					local var_249_9 = manager.audio:GetVoiceLength("story_v_out_112201", "112201064", "story_v_out_112201.awb") / 1000

					if var_249_9 + var_249_3 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_3
					end

					if var_249_5.prefab_name ~= "" and arg_246_1.actors_[var_249_5.prefab_name] ~= nil then
						local var_249_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_5.prefab_name].transform, "story_v_out_112201", "112201064", "story_v_out_112201.awb")

						arg_246_1:RecordAudio("112201064", var_249_10)
						arg_246_1:RecordAudio("112201064", var_249_10)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_112201", "112201064", "story_v_out_112201.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_112201", "112201064", "story_v_out_112201.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_11 = math.max(var_249_4, arg_246_1.talkMaxDuration)

			if var_249_3 <= arg_246_1.time_ and arg_246_1.time_ < var_249_3 + var_249_11 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_3) / var_249_11

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_3 + var_249_11 and arg_246_1.time_ < var_249_3 + var_249_11 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play112201065 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 112201065
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play112201066(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1039ui_story = arg_250_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1039ui_story"].transform.position).z)
				arg_250_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1039ui_story"].transform.localEulerAngles = arg_250_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1039ui_story"].transform.position).z)
				arg_250_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1039ui_story"].transform.localEulerAngles = arg_250_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_253_1 = 0
			local var_253_2 = 0.325

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(112201065).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 13 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 13)

				if (13 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 13)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play112201066 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 112201066
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play112201067(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.65

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(112201066).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 26 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 26)

				if (26 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 26)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play112201067 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 112201067
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play112201068(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.25

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(112201067).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 10 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 10)

				if (10 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 10)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play112201068 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 112201068
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play112201069(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 1.025

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(112201068).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 41 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 41)

				if (41 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 41)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play112201069 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 112201069
		arg_266_1.duration_ = 3.43

		local var_266_0 = {
			ja = 3.166,
			ko = 3.1,
			zh = 3.433,
			en = 2.5
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play112201070(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1039ui_story = arg_266_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1039ui_story"].transform.position).z)
				arg_266_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1039ui_story"].transform.localEulerAngles = arg_266_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				arg_266_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1039ui_story"].transform.position).z)
				arg_266_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1039ui_story"].transform.localEulerAngles = arg_266_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_269_1 = arg_266_1.actors_["1039ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1039ui_story == nil then
				arg_266_1.var_.characterEffect1039ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1039ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1039ui_story then
				arg_266_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_269_4 = 0
			local var_269_5 = 0.275

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(112201069)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 11 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 11)

				if (11 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 11)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201069", "story_v_out_112201.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_112201", "112201069", "story_v_out_112201.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_112201", "112201069", "story_v_out_112201.awb")

						arg_266_1:RecordAudio("112201069", var_269_11)
						arg_266_1:RecordAudio("112201069", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_112201", "112201069", "story_v_out_112201.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_112201", "112201069", "story_v_out_112201.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play112201070 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 112201070
		arg_270_1.duration_ = 6.03

		local var_270_0 = {
			ja = 3.766,
			ko = 6.033,
			zh = 4.933,
			en = 5
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play112201071(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_273_0 = arg_270_1.actors_["1148ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1148ui_story = var_273_0.localPosition
			end

			local var_273_1 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_1 then
				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_270_1.time_ - 0) / var_273_1)
				var_273_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_0.position).x, (manager.ui.mainCamera.transform.position - var_273_0.position).y, (manager.ui.mainCamera.transform.position - var_273_0.position).z)
				var_273_0.localEulerAngles.z = 0
				var_273_0.localEulerAngles.x = 0
				var_273_0.localEulerAngles = var_273_0.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_1 and arg_270_1.time_ < 0 + var_273_1 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_273_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_0.position).x, (manager.ui.mainCamera.transform.position - var_273_0.position).y, (manager.ui.mainCamera.transform.position - var_273_0.position).z)
				var_273_0.localEulerAngles.z = 0
				var_273_0.localEulerAngles.x = 0
				var_273_0.localEulerAngles = var_273_0.localEulerAngles
			end

			local var_273_2 = arg_270_1.actors_["1148ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.characterEffect1148ui_story == nil then
				arg_270_1.var_.characterEffect1148ui_story = var_273_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_3 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.characterEffect1148ui_story and not isNil(var_273_2) then
					arg_270_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.characterEffect1148ui_story then
				arg_270_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_273_5 = arg_270_1.actors_["1039ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1039ui_story == nil then
				arg_270_1.var_.characterEffect1039ui_story = var_273_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.characterEffect1039ui_story and not isNil(var_273_5) then
					arg_270_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_6)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_6 and arg_270_1.time_ < 0 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1039ui_story then
				arg_270_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_273_7 = 0
			local var_273_8 = 0.6

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_7 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_9 = arg_270_1:GetWordFromCfg(112201070)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_12 = 24 <= 0 and var_273_8 or var_273_8 * (utf8.len(var_273_10) / 24)

				if (24 <= 0 and var_273_8 or var_273_8 * (utf8.len(var_273_10) / 24)) > 0 and var_273_8 < var_273_12 then
					arg_270_1.talkMaxDuration = var_273_12

					if var_273_12 + var_273_7 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_12 + var_273_7
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201070", "story_v_out_112201.awb") ~= 0 then
					local var_273_13 = manager.audio:GetVoiceLength("story_v_out_112201", "112201070", "story_v_out_112201.awb") / 1000

					if var_273_13 + var_273_7 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_7
					end

					if var_273_9.prefab_name ~= "" and arg_270_1.actors_[var_273_9.prefab_name] ~= nil then
						local var_273_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_9.prefab_name].transform, "story_v_out_112201", "112201070", "story_v_out_112201.awb")

						arg_270_1:RecordAudio("112201070", var_273_14)
						arg_270_1:RecordAudio("112201070", var_273_14)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_112201", "112201070", "story_v_out_112201.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_112201", "112201070", "story_v_out_112201.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_15 = math.max(var_273_8, arg_270_1.talkMaxDuration)

			if var_273_7 <= arg_270_1.time_ and arg_270_1.time_ < var_273_7 + var_273_15 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_7) / var_273_15

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_7 + var_273_15 and arg_270_1.time_ < var_273_7 + var_273_15 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play112201071 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 112201071
		arg_274_1.duration_ = 5

		local var_274_0 = {
			ja = 5,
			ko = 3.5,
			zh = 3.033,
			en = 2.433
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play112201072(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1148ui_story = arg_274_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1148ui_story"].transform.position).z)
				arg_274_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1148ui_story"].transform.localEulerAngles = arg_274_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1148ui_story"].transform.position).z)
				arg_274_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1148ui_story"].transform.localEulerAngles = arg_274_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["1039ui_story"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1039ui_story = var_277_1.localPosition
			end

			local var_277_2 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 then
				var_277_1.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_2)
				var_277_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_1.position).x, (manager.ui.mainCamera.transform.position - var_277_1.position).y, (manager.ui.mainCamera.transform.position - var_277_1.position).z)
				var_277_1.localEulerAngles.z = 0
				var_277_1.localEulerAngles.x = 0
				var_277_1.localEulerAngles = var_277_1.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 then
				var_277_1.localPosition = Vector3.New(0, 100, 0)
				var_277_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_1.position).x, (manager.ui.mainCamera.transform.position - var_277_1.position).y, (manager.ui.mainCamera.transform.position - var_277_1.position).z)
				var_277_1.localEulerAngles.z = 0
				var_277_1.localEulerAngles.x = 0
				var_277_1.localEulerAngles = var_277_1.localEulerAngles
			end

			local var_277_3 = 0
			local var_277_4 = 0.3

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_5 = arg_274_1:GetWordFromCfg(112201071)
				local var_277_6 = arg_274_1:FormatText(var_277_5.content)

				arg_274_1.text_.text = var_277_6

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_8 = 12 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_6) / 12)

				if (12 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_6) / 12)) > 0 and var_277_4 < var_277_8 then
					arg_274_1.talkMaxDuration = var_277_8

					if var_277_8 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_3
					end
				end

				arg_274_1.text_.text = var_277_6
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201071", "story_v_out_112201.awb") ~= 0 then
					local var_277_9 = manager.audio:GetVoiceLength("story_v_out_112201", "112201071", "story_v_out_112201.awb") / 1000

					if var_277_9 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_3
					end

					if var_277_5.prefab_name ~= "" and arg_274_1.actors_[var_277_5.prefab_name] ~= nil then
						local var_277_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_5.prefab_name].transform, "story_v_out_112201", "112201071", "story_v_out_112201.awb")

						arg_274_1:RecordAudio("112201071", var_277_10)
						arg_274_1:RecordAudio("112201071", var_277_10)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_112201", "112201071", "story_v_out_112201.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_112201", "112201071", "story_v_out_112201.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_11 = math.max(var_277_4, arg_274_1.talkMaxDuration)

			if var_277_3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_3 + var_277_11 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_3) / var_277_11

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_3 + var_277_11 and arg_274_1.time_ < var_277_3 + var_277_11 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play112201072 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 112201072
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play112201073(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.5

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(112201072).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 20)

				if (20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 20)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play112201073 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 112201073
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play112201074(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.85

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(112201073).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 34 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 34)

				if (34 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 34)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play112201074 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 112201074
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play112201075(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 1.425

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(112201074).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 57 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 57)

				if (57 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 57)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play112201075 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 112201075
		arg_290_1.duration_ = 4

		local var_290_0 = {
			ja = 4,
			ko = 3.266,
			zh = 2.833,
			en = 3.666
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play112201076(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_293_0 = arg_290_1.actors_["1084ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1084ui_story == nil then
				arg_290_1.var_.characterEffect1084ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_1 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_1 and not isNil(var_293_0) then
				if arg_290_1.var_.characterEffect1084ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_1 and arg_290_1.time_ < 0 + var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1084ui_story then
				arg_290_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_293_3 = arg_290_1.actors_["1084ui_story"].transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1084ui_story = var_293_3.localPosition
			end

			local var_293_4 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				var_293_3.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_290_1.time_ - 0) / var_293_4)
				var_293_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_3.position).x, (manager.ui.mainCamera.transform.position - var_293_3.position).y, (manager.ui.mainCamera.transform.position - var_293_3.position).z)
				var_293_3.localEulerAngles.z = 0
				var_293_3.localEulerAngles.x = 0
				var_293_3.localEulerAngles = var_293_3.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				var_293_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_293_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_3.position).x, (manager.ui.mainCamera.transform.position - var_293_3.position).y, (manager.ui.mainCamera.transform.position - var_293_3.position).z)
				var_293_3.localEulerAngles.z = 0
				var_293_3.localEulerAngles.x = 0
				var_293_3.localEulerAngles = var_293_3.localEulerAngles
			end

			local var_293_5 = 0
			local var_293_6 = 0.35

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_7 = arg_290_1:GetWordFromCfg(112201075)
				local var_293_8 = arg_290_1:FormatText(var_293_7.content)

				arg_290_1.text_.text = var_293_8

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_10 = 14 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 14)

				if (14 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 14)) > 0 and var_293_6 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_5
					end
				end

				arg_290_1.text_.text = var_293_8
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201075", "story_v_out_112201.awb") ~= 0 then
					local var_293_11 = manager.audio:GetVoiceLength("story_v_out_112201", "112201075", "story_v_out_112201.awb") / 1000

					if var_293_11 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_11 + var_293_5
					end

					if var_293_7.prefab_name ~= "" and arg_290_1.actors_[var_293_7.prefab_name] ~= nil then
						local var_293_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_7.prefab_name].transform, "story_v_out_112201", "112201075", "story_v_out_112201.awb")

						arg_290_1:RecordAudio("112201075", var_293_12)
						arg_290_1:RecordAudio("112201075", var_293_12)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_112201", "112201075", "story_v_out_112201.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_112201", "112201075", "story_v_out_112201.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_6, arg_290_1.talkMaxDuration)

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_5) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_5 + var_293_13 and arg_290_1.time_ < var_293_5 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play112201076 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 112201076
		arg_294_1.duration_ = 5.9

		local var_294_0 = {
			ja = 3.066,
			ko = 4.533,
			zh = 4.8,
			en = 5.9
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play112201077(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1027ui_story = arg_294_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1027ui_story"].transform.position).z)
				arg_294_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1027ui_story"].transform.localEulerAngles = arg_294_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_294_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1027ui_story"].transform.position).z)
				arg_294_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1027ui_story"].transform.localEulerAngles = arg_294_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_297_1 = arg_294_1.actors_["1027ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect1027ui_story == nil then
				arg_294_1.var_.characterEffect1027ui_story = var_297_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_2 and not isNil(var_297_1) then
				if arg_294_1.var_.characterEffect1027ui_story and not isNil(var_297_1) then
					arg_294_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_2 and arg_294_1.time_ < 0 + var_297_2 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect1027ui_story then
				arg_294_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_297_4 = arg_294_1.actors_["1084ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_4) and arg_294_1.var_.characterEffect1084ui_story == nil then
				arg_294_1.var_.characterEffect1084ui_story = var_297_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_5 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_5 and not isNil(var_297_4) then
				if arg_294_1.var_.characterEffect1084ui_story and not isNil(var_297_4) then
					arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_5)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_5 and arg_294_1.time_ < 0 + var_297_5 + arg_297_0 and not isNil(var_297_4) and arg_294_1.var_.characterEffect1084ui_story then
				arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_297_6 = 0
			local var_297_7 = 0.525

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:GetWordFromCfg(112201076)
				local var_297_9 = arg_294_1:FormatText(var_297_8.content)

				arg_294_1.text_.text = var_297_9

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_11 = 21 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_9) / 21)

				if (21 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_9) / 21)) > 0 and var_297_7 < var_297_11 then
					arg_294_1.talkMaxDuration = var_297_11

					if var_297_11 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_11 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_9
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201076", "story_v_out_112201.awb") ~= 0 then
					local var_297_12 = manager.audio:GetVoiceLength("story_v_out_112201", "112201076", "story_v_out_112201.awb") / 1000

					if var_297_12 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_6
					end

					if var_297_8.prefab_name ~= "" and arg_294_1.actors_[var_297_8.prefab_name] ~= nil then
						local var_297_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_8.prefab_name].transform, "story_v_out_112201", "112201076", "story_v_out_112201.awb")

						arg_294_1:RecordAudio("112201076", var_297_13)
						arg_294_1:RecordAudio("112201076", var_297_13)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_112201", "112201076", "story_v_out_112201.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_112201", "112201076", "story_v_out_112201.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_14 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_14 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_14

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_14 and arg_294_1.time_ < var_297_6 + var_297_14 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play112201077 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 112201077
		arg_298_1.duration_ = 8.23

		local var_298_0 = {
			ja = 8.233,
			ko = 4.433,
			zh = 3.9,
			en = 6.033
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play112201078(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_301_0 = arg_298_1.actors_["1148ui_story"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1148ui_story = var_301_0.localPosition
			end

			local var_301_1 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_1 then
				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_298_1.time_ - 0) / var_301_1)
				var_301_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_0.position).x, (manager.ui.mainCamera.transform.position - var_301_0.position).y, (manager.ui.mainCamera.transform.position - var_301_0.position).z)
				var_301_0.localEulerAngles.z = 0
				var_301_0.localEulerAngles.x = 0
				var_301_0.localEulerAngles = var_301_0.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_1 and arg_298_1.time_ < 0 + var_301_1 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_301_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_0.position).x, (manager.ui.mainCamera.transform.position - var_301_0.position).y, (manager.ui.mainCamera.transform.position - var_301_0.position).z)
				var_301_0.localEulerAngles.z = 0
				var_301_0.localEulerAngles.x = 0
				var_301_0.localEulerAngles = var_301_0.localEulerAngles
			end

			local var_301_2 = arg_298_1.actors_["1148ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.characterEffect1148ui_story == nil then
				arg_298_1.var_.characterEffect1148ui_story = var_301_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_3 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_3 and not isNil(var_301_2) then
				if arg_298_1.var_.characterEffect1148ui_story and not isNil(var_301_2) then
					arg_298_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_3 and arg_298_1.time_ < 0 + var_301_3 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.characterEffect1148ui_story then
				arg_298_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_301_5 = arg_298_1.actors_["1084ui_story"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1084ui_story = var_301_5.localPosition
			end

			local var_301_6 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_6 then
				var_301_5.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_6)
				var_301_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_5.position).x, (manager.ui.mainCamera.transform.position - var_301_5.position).y, (manager.ui.mainCamera.transform.position - var_301_5.position).z)
				var_301_5.localEulerAngles.z = 0
				var_301_5.localEulerAngles.x = 0
				var_301_5.localEulerAngles = var_301_5.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_6 and arg_298_1.time_ < 0 + var_301_6 + arg_301_0 then
				var_301_5.localPosition = Vector3.New(0, 100, 0)
				var_301_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_5.position).x, (manager.ui.mainCamera.transform.position - var_301_5.position).y, (manager.ui.mainCamera.transform.position - var_301_5.position).z)
				var_301_5.localEulerAngles.z = 0
				var_301_5.localEulerAngles.x = 0
				var_301_5.localEulerAngles = var_301_5.localEulerAngles
			end

			local var_301_7 = 0
			local var_301_8 = 0.425

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_7 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_9 = arg_298_1:GetWordFromCfg(112201077)
				local var_301_10 = arg_298_1:FormatText(var_301_9.content)

				arg_298_1.text_.text = var_301_10

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_12 = 17 <= 0 and var_301_8 or var_301_8 * (utf8.len(var_301_10) / 17)

				if (17 <= 0 and var_301_8 or var_301_8 * (utf8.len(var_301_10) / 17)) > 0 and var_301_8 < var_301_12 then
					arg_298_1.talkMaxDuration = var_301_12

					if var_301_12 + var_301_7 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_12 + var_301_7
					end
				end

				arg_298_1.text_.text = var_301_10
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201077", "story_v_out_112201.awb") ~= 0 then
					local var_301_13 = manager.audio:GetVoiceLength("story_v_out_112201", "112201077", "story_v_out_112201.awb") / 1000

					if var_301_13 + var_301_7 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_13 + var_301_7
					end

					if var_301_9.prefab_name ~= "" and arg_298_1.actors_[var_301_9.prefab_name] ~= nil then
						local var_301_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_9.prefab_name].transform, "story_v_out_112201", "112201077", "story_v_out_112201.awb")

						arg_298_1:RecordAudio("112201077", var_301_14)
						arg_298_1:RecordAudio("112201077", var_301_14)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_112201", "112201077", "story_v_out_112201.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_112201", "112201077", "story_v_out_112201.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_15 = math.max(var_301_8, arg_298_1.talkMaxDuration)

			if var_301_7 <= arg_298_1.time_ and arg_298_1.time_ < var_301_7 + var_301_15 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_7) / var_301_15

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_7 + var_301_15 and arg_298_1.time_ < var_301_7 + var_301_15 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play112201078 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 112201078
		arg_302_1.duration_ = 14.93

		local var_302_0 = {
			ja = 9.5,
			ko = 9.866,
			zh = 9.566,
			en = 14.933
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play112201079(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1148ui_story"]) and arg_302_1.var_.characterEffect1148ui_story == nil then
				arg_302_1.var_.characterEffect1148ui_story = arg_302_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1148ui_story"]) then
				if arg_302_1.var_.characterEffect1148ui_story and not isNil(arg_302_1.actors_["1148ui_story"]) then
					arg_302_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_302_1.time_ - 0) / var_305_0)
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1148ui_story"]) and arg_302_1.var_.characterEffect1148ui_story then
				arg_302_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action462")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_305_1 = arg_302_1.actors_["1027ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1027ui_story == nil then
				arg_302_1.var_.characterEffect1027ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1027ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1027ui_story then
				arg_302_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_305_4 = 0
			local var_305_5 = 1.325

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(112201078)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 53 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 53)

				if (53 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 53)) > 0 and var_305_5 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201078", "story_v_out_112201.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_out_112201", "112201078", "story_v_out_112201.awb") / 1000

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end

					if var_305_6.prefab_name ~= "" and arg_302_1.actors_[var_305_6.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_6.prefab_name].transform, "story_v_out_112201", "112201078", "story_v_out_112201.awb")

						arg_302_1:RecordAudio("112201078", var_305_11)
						arg_302_1:RecordAudio("112201078", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_112201", "112201078", "story_v_out_112201.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_112201", "112201078", "story_v_out_112201.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play112201079 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 112201079
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play112201080(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1027ui_story"]) and arg_306_1.var_.characterEffect1027ui_story == nil then
				arg_306_1.var_.characterEffect1027ui_story = arg_306_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1027ui_story"]) then
				if arg_306_1.var_.characterEffect1027ui_story and not isNil(arg_306_1.actors_["1027ui_story"]) then
					arg_306_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1027ui_story"]) and arg_306_1.var_.characterEffect1027ui_story then
				arg_306_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.3

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(112201079).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 12 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 12)

				if (12 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 12)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play112201080 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 112201080
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play112201081(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action423")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_313_0 = arg_310_1.actors_["1027ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1027ui_story == nil then
				arg_310_1.var_.characterEffect1027ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_1 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_1 and not isNil(var_313_0) then
				if arg_310_1.var_.characterEffect1027ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_1 and arg_310_1.time_ < 0 + var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1027ui_story then
				arg_310_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_313_3 = 0
			local var_313_4 = 0.35

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_3 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_5 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(112201080).content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_7 = 14 <= 0 and var_313_4 or var_313_4 * (utf8.len(var_313_5) / 14)

				if (14 <= 0 and var_313_4 or var_313_4 * (utf8.len(var_313_5) / 14)) > 0 and var_313_4 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_3 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_3
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_4, arg_310_1.talkMaxDuration)

			if var_313_3 <= arg_310_1.time_ and arg_310_1.time_ < var_313_3 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_3) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_3 + var_313_8 and arg_310_1.time_ < var_313_3 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play112201081 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 112201081
		arg_314_1.duration_ = 5.07

		local var_314_0 = {
			ja = 5.066,
			ko = 3.6,
			zh = 3.6,
			en = 3.3
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play112201082(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_317_0 = 0
			local var_317_1 = 0.325

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(112201081)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 13 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 13)

				if (13 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 13)) > 0 and var_317_1 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201081", "story_v_out_112201.awb") ~= 0 then
					local var_317_6 = manager.audio:GetVoiceLength("story_v_out_112201", "112201081", "story_v_out_112201.awb") / 1000

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end

					if var_317_2.prefab_name ~= "" and arg_314_1.actors_[var_317_2.prefab_name] ~= nil then
						local var_317_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_2.prefab_name].transform, "story_v_out_112201", "112201081", "story_v_out_112201.awb")

						arg_314_1:RecordAudio("112201081", var_317_7)
						arg_314_1:RecordAudio("112201081", var_317_7)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_112201", "112201081", "story_v_out_112201.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_112201", "112201081", "story_v_out_112201.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_8 and arg_314_1.time_ < var_317_0 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play112201082 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 112201082
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play112201083(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1027ui_story = arg_318_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1027ui_story"].transform.position).z)
				arg_318_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1027ui_story"].transform.localEulerAngles = arg_318_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_318_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1027ui_story"].transform.position).z)
				arg_318_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1027ui_story"].transform.localEulerAngles = arg_318_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_321_1 = arg_318_1.actors_["1148ui_story"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1148ui_story = var_321_1.localPosition
			end

			local var_321_2 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_2 then
				var_321_1.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_318_1.time_ - 0) / var_321_2)
				var_321_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_1.position).x, (manager.ui.mainCamera.transform.position - var_321_1.position).y, (manager.ui.mainCamera.transform.position - var_321_1.position).z)
				var_321_1.localEulerAngles.z = 0
				var_321_1.localEulerAngles.x = 0
				var_321_1.localEulerAngles = var_321_1.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_2 and arg_318_1.time_ < 0 + var_321_2 + arg_321_0 then
				var_321_1.localPosition = Vector3.New(0, 100, 0)
				var_321_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_1.position).x, (manager.ui.mainCamera.transform.position - var_321_1.position).y, (manager.ui.mainCamera.transform.position - var_321_1.position).z)
				var_321_1.localEulerAngles.z = 0
				var_321_1.localEulerAngles.x = 0
				var_321_1.localEulerAngles = var_321_1.localEulerAngles
			end

			local var_321_3 = 0
			local var_321_4 = 0.3

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_3 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_5 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(112201082).content)

				arg_318_1.text_.text = var_321_5

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_7 = 12 <= 0 and var_321_4 or var_321_4 * (utf8.len(var_321_5) / 12)

				if (12 <= 0 and var_321_4 or var_321_4 * (utf8.len(var_321_5) / 12)) > 0 and var_321_4 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_3 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_3
					end
				end

				arg_318_1.text_.text = var_321_5
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_4, arg_318_1.talkMaxDuration)

			if var_321_3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_3 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_3) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_3 + var_321_8 and arg_318_1.time_ < var_321_3 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play112201083 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 112201083
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
			arg_322_1.auto_ = false
		end

		function arg_322_1.playNext_(arg_324_0)
			arg_322_1.onStoryFinished_()
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.6

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(112201083).content)

				arg_322_1.text_.text = var_325_1

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_3 = 24 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 24)

				if (24 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 24)) > 0 and var_325_0 < var_325_3 then
					arg_322_1.talkMaxDuration = var_325_3

					if var_325_3 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_3 + 0
					end
				end

				arg_322_1.text_.text = var_325_1
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_4 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_4

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play112201049 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 112201049
		arg_326_1.duration_ = 5.87

		local var_326_0 = {
			ja = 5.566,
			ko = 5.866,
			zh = 3.4,
			en = 4.266
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play112201050(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if arg_326_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_329_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_326_1.stage_.transform)

				var_329_0.name = "1084ui_story"
				var_329_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_["1084ui_story"] = var_329_0

				local var_329_1 = var_329_0:GetComponentInChildren(typeof(CharacterEffect))

				var_329_1.enabled = true

				local var_329_2 = GameObjectTools.GetOrAddComponent(var_329_0, typeof(DynamicBoneHelper))

				if var_329_2 then
					var_329_2:EnableDynamicBone(false)
				end

				arg_326_1:ShowWeapon(var_329_1.transform, false)

				arg_326_1.var_["1084ui_story" .. "Animator"] = var_329_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_326_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_326_1.var_["1084ui_story" .. "LipSync"] = var_329_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_329_3 = arg_326_1.actors_["1084ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_3) and arg_326_1.var_.characterEffect1084ui_story == nil then
				arg_326_1.var_.characterEffect1084ui_story = var_329_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_4 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 and not isNil(var_329_3) then
				if arg_326_1.var_.characterEffect1084ui_story and not isNil(var_329_3) then
					arg_326_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 and not isNil(var_329_3) and arg_326_1.var_.characterEffect1084ui_story then
				arg_326_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_329_6 = "1084ui_story"

			if arg_326_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_329_7 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_326_1.stage_.transform)

				var_329_7.name = var_329_6
				var_329_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_[var_329_6] = var_329_7

				local var_329_8 = var_329_7:GetComponentInChildren(typeof(CharacterEffect))

				var_329_8.enabled = true

				local var_329_9 = GameObjectTools.GetOrAddComponent(var_329_7, typeof(DynamicBoneHelper))

				if var_329_9 then
					var_329_9:EnableDynamicBone(false)
				end

				arg_326_1:ShowWeapon(var_329_8.transform, false)

				arg_326_1.var_[var_329_6 .. "Animator"] = var_329_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_326_1.var_[var_329_6 .. "Animator"].applyRootMotion = true
				arg_326_1.var_[var_329_6 .. "LipSync"] = var_329_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_329_10 = 0
			local var_329_11 = 0.4

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_12 = arg_326_1:GetWordFromCfg(112201049)
				local var_329_13 = arg_326_1:FormatText(var_329_12.content)

				arg_326_1.text_.text = var_329_13

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_15 = 16 <= 0 and var_329_11 or var_329_11 * (utf8.len(var_329_13) / 16)

				if (16 <= 0 and var_329_11 or var_329_11 * (utf8.len(var_329_13) / 16)) > 0 and var_329_11 < var_329_15 then
					arg_326_1.talkMaxDuration = var_329_15

					if var_329_15 + var_329_10 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_15 + var_329_10
					end
				end

				arg_326_1.text_.text = var_329_13
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112201", "112201049", "story_v_out_112201.awb") ~= 0 then
					local var_329_16 = manager.audio:GetVoiceLength("story_v_out_112201", "112201049", "story_v_out_112201.awb") / 1000

					if var_329_16 + var_329_10 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_16 + var_329_10
					end

					if var_329_12.prefab_name ~= "" and arg_326_1.actors_[var_329_12.prefab_name] ~= nil then
						local var_329_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_12.prefab_name].transform, "story_v_out_112201", "112201049", "story_v_out_112201.awb")

						arg_326_1:RecordAudio("112201049", var_329_17)
						arg_326_1:RecordAudio("112201049", var_329_17)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_112201", "112201049", "story_v_out_112201.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_112201", "112201049", "story_v_out_112201.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_18 = math.max(var_329_11, arg_326_1.talkMaxDuration)

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_18 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_10) / var_329_18

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_10 + var_329_18 and arg_326_1.time_ < var_329_10 + var_329_18 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play112201050 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 112201050
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play112201051(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1084ui_story = arg_330_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).z)
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles = arg_330_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_330_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).z)
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles = arg_330_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["1148ui_story"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1148ui_story = var_333_1.localPosition
			end

			local var_333_2 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 then
				var_333_1.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_330_1.time_ - 0) / var_333_2)
				var_333_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_1.position).x, (manager.ui.mainCamera.transform.position - var_333_1.position).y, (manager.ui.mainCamera.transform.position - var_333_1.position).z)
				var_333_1.localEulerAngles.z = 0
				var_333_1.localEulerAngles.x = 0
				var_333_1.localEulerAngles = var_333_1.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 then
				var_333_1.localPosition = Vector3.New(0, 100, 0)
				var_333_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_1.position).x, (manager.ui.mainCamera.transform.position - var_333_1.position).y, (manager.ui.mainCamera.transform.position - var_333_1.position).z)
				var_333_1.localEulerAngles.z = 0
				var_333_1.localEulerAngles.x = 0
				var_333_1.localEulerAngles = var_333_1.localEulerAngles
			end

			local var_333_3 = 0
			local var_333_4 = 1

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_3 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_5 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(112201050).content)

				arg_330_1.text_.text = var_333_5

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_7 = 40 <= 0 and var_333_4 or var_333_4 * (utf8.len(var_333_5) / 40)

				if (40 <= 0 and var_333_4 or var_333_4 * (utf8.len(var_333_5) / 40)) > 0 and var_333_4 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_3 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_3
					end
				end

				arg_330_1.text_.text = var_333_5
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_8 = math.max(var_333_4, arg_330_1.talkMaxDuration)

			if var_333_3 <= arg_330_1.time_ and arg_330_1.time_ < var_333_3 + var_333_8 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_3) / var_333_8

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_3 + var_333_8 and arg_330_1.time_ < var_333_3 + var_333_8 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play112201051 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 112201051
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play112201052(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 1

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(112201051).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 19 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 19)

				if (19 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 19)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02",
		"TextureConfig/Background/H03"
	},
	voices = {
		"story_v_out_112201.awb"
	}
}

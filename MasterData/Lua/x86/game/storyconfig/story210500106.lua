return {
	Play1105006001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1105006001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1105006002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST16 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST16")
				var_4_0.name = "ST16"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST16 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST16

				arg_1_1.bgs_.ST16.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST16" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 1.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1105006001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 49 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 49)

				if (49 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 49)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1105006002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1105006002
		arg_9_1.duration_ = 2.23

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1105006003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["115001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "115001ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "115001ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "115001ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["115001ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["115001ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["115001ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["115001ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["115001ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos115001ui_story = var_12_3.localPosition

				arg_9_1:ShowWeapon(arg_9_1.var_["115001ui_story" .. "Animator"].transform, false)
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.033, -6.3)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["115001ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect115001ui_story == nil then
				arg_9_1.var_.characterEffect115001ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect115001ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect115001ui_story then
				arg_9_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(1105006002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 12 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 12)

				if (12 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 12)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb")

						arg_9_1:RecordAudio("1105006002", var_12_15)
						arg_9_1:RecordAudio("1105006002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006002", "story_v_side_new_1105006.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play1105006003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1105006003
		arg_13_1.duration_ = 9.03

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1105006004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.95

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(1105006003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 38)

				if (38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 38)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb")

						arg_13_1:RecordAudio("1105006003", var_16_6)
						arg_13_1:RecordAudio("1105006003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006003", "story_v_side_new_1105006.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1105006004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1105006004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1105006005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["115001ui_story"]) and arg_17_1.var_.characterEffect115001ui_story == nil then
				arg_17_1.var_.characterEffect115001ui_story = arg_17_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["115001ui_story"]) then
				if arg_17_1.var_.characterEffect115001ui_story and not isNil(arg_17_1.actors_["115001ui_story"]) then
					arg_17_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_17_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["115001ui_story"]) and arg_17_1.var_.characterEffect115001ui_story then
				arg_17_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_17_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.6

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1105006004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 24 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 24)

				if (24 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 24)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1105006005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1105006005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1105006006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.35

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1105006005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 14 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 14)

				if (14 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 14)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1105006006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1105006006
		arg_25_1.duration_ = 2.57

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1105006007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["115001ui_story"]) and arg_25_1.var_.characterEffect115001ui_story == nil then
				arg_25_1.var_.characterEffect115001ui_story = arg_25_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["115001ui_story"]) then
				if arg_25_1.var_.characterEffect115001ui_story and not isNil(arg_25_1.actors_["115001ui_story"]) then
					arg_25_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["115001ui_story"]) and arg_25_1.var_.characterEffect115001ui_story then
				arg_25_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			local var_28_2 = 0
			local var_28_3 = 0.175

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(1105006006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 7 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 7)

				if (7 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 7)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb")

						arg_25_1:RecordAudio("1105006006", var_28_9)
						arg_25_1:RecordAudio("1105006006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006006", "story_v_side_new_1105006.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1105006007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1105006007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1105006008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos115001ui_story = arg_29_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["115001ui_story"].transform.position).z)
				arg_29_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["115001ui_story"].transform.localEulerAngles = arg_29_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["115001ui_story"].transform.position).z)
				arg_29_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["115001ui_story"].transform.localEulerAngles = arg_29_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_32_1 = 0
			local var_32_2 = 0.8

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1105006007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 32 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 32)

				if (32 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 32)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play1105006008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1105006008
		arg_33_1.duration_ = 5.07

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1105006009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["115001ui_story"]) and arg_33_1.var_.characterEffect115001ui_story == nil then
				arg_33_1.var_.characterEffect115001ui_story = arg_33_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["115001ui_story"]) then
				if arg_33_1.var_.characterEffect115001ui_story and not isNil(arg_33_1.actors_["115001ui_story"]) then
					arg_33_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["115001ui_story"]) and arg_33_1.var_.characterEffect115001ui_story then
				arg_33_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_36_2 = arg_33_1.actors_["115001ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos115001ui_story = var_36_2.localPosition
			end

			local var_36_3 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_33_1.time_ - 0) / var_36_3)
				var_36_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_2.position).x, (manager.ui.mainCamera.transform.position - var_36_2.position).y, (manager.ui.mainCamera.transform.position - var_36_2.position).z)
				var_36_2.localEulerAngles.z = 0
				var_36_2.localEulerAngles.x = 0
				var_36_2.localEulerAngles = var_36_2.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_36_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_2.position).x, (manager.ui.mainCamera.transform.position - var_36_2.position).y, (manager.ui.mainCamera.transform.position - var_36_2.position).z)
				var_36_2.localEulerAngles.z = 0
				var_36_2.localEulerAngles.x = 0
				var_36_2.localEulerAngles = var_36_2.localEulerAngles
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(1105006008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 25 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 25)

				if (25 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 25)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb")

						arg_33_1:RecordAudio("1105006008", var_36_11)
						arg_33_1:RecordAudio("1105006008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006008", "story_v_side_new_1105006.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play1105006009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1105006009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1105006010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos115001ui_story = arg_37_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["115001ui_story"].transform.position).z)
				arg_37_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["115001ui_story"].transform.localEulerAngles = arg_37_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["115001ui_story"].transform.position).z)
				arg_37_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["115001ui_story"].transform.localEulerAngles = arg_37_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_40_1 = 0
			local var_40_2 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1105006009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 7 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 7)

				if (7 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 7)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1105006010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1105006010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1105006011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1105006010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 51 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 51)

				if (51 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 51)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1105006011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1105006011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1105006012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1105006011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 51 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 51)

				if (51 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 51)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1105006012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1105006012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1105006013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1105006012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 52 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 52)

				if (52 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 52)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1105006013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1105006013
		arg_53_1.duration_ = 5.97

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1105006014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_0 = arg_53_1.var_.effect11

				if not arg_53_1.var_.effect11 then
					var_56_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_56_0.name = "1"
					arg_53_1.var_.effect11 = var_56_0
				else
					var_56_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_56_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_56_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_56_2 = manager.ui.mainCamera.transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_2.localPosition
			end

			local var_56_3 = 0.833333333333333

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 then
				local var_56_4, var_56_5 = math.modf((arg_53_1.time_ - 0) / 0.066)

				var_56_2.localPosition = Vector3.New(var_56_5 * 0.13, var_56_5 * 0.13, var_56_5 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 then
				var_56_2.localPosition = arg_53_1.var_.shakeOldPos
			end

			if 0.266666666666667 < arg_53_1.time_ and arg_53_1.time_ <= 0.266666666666667 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_bamboo1", "")
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_7 = 0.966666666666667
			local var_56_8 = 0.95

			if 0.966666666666667 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_9 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_9:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1105006013).content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 38 <= 0 and var_56_8 or var_56_8 * (utf8.len(var_56_10) / 38)

				if (38 <= 0 and var_56_8 or var_56_8 * (utf8.len(var_56_10) / 38)) > 0 and var_56_8 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12
					var_56_7 = var_56_7 + 0.3

					if var_56_12 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_7
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = var_56_7 + 0.3
			local var_56_14 = math.max(var_56_8, arg_53_1.talkMaxDuration)

			if var_56_7 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_13 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_13) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_13 + var_56_14 and arg_53_1.time_ < var_56_13 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1105006014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1105006014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1105006015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.325

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1105006014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 13 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 13)

				if (13 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 13)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1105006015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1105006015
		arg_63_1.duration_ = 2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1105006016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos115001ui_story = arg_63_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["115001ui_story"].transform.position).z)
				arg_63_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["115001ui_story"].transform.localEulerAngles = arg_63_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, -1.033, -6.3)
				arg_63_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["115001ui_story"].transform.position).z)
				arg_63_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["115001ui_story"].transform.localEulerAngles = arg_63_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["115001ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect115001ui_story == nil then
				arg_63_1.var_.characterEffect115001ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect115001ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect115001ui_story then
				arg_63_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_66_4 = 0
			local var_66_5 = 0.275

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(1105006015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 11 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 11)

				if (11 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 11)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb")

						arg_63_1:RecordAudio("1105006015", var_66_11)
						arg_63_1:RecordAudio("1105006015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006015", "story_v_side_new_1105006.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play1105006016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1105006016
		arg_67_1.duration_ = 4.43

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1105006017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.675

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(1105006016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 27 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 27)

				if (27 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 27)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb")

						arg_67_1:RecordAudio("1105006016", var_70_6)
						arg_67_1:RecordAudio("1105006016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006016", "story_v_side_new_1105006.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1105006017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1105006017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1105006018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos115001ui_story = arg_71_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["115001ui_story"].transform.position).z)
				arg_71_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["115001ui_story"].transform.localEulerAngles = arg_71_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["115001ui_story"].transform.position).z)
				arg_71_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["115001ui_story"].transform.localEulerAngles = arg_71_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_74_1 = 0
			local var_74_2 = 0.975

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1105006017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 39 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 39)

				if (39 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 39)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play1105006018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1105006018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1105006019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0.8 < arg_75_1.time_ and arg_75_1.time_ <= 0.8 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_bamboo2", "")
			end

			local var_78_1 = 0
			local var_78_2 = 1.825

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1105006018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 73 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 73)

				if (73 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 73)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1105006019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1105006019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1105006020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.625

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1105006019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 25 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 25)

				if (25 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 25)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1105006020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1105006020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1105006021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.275

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(1105006020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 11 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 11)

				if (11 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 11)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1105006021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1105006021
		arg_87_1.duration_ = 2.8

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1105006022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos115001ui_story = arg_87_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["115001ui_story"].transform.position).z)
				arg_87_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["115001ui_story"].transform.localEulerAngles = arg_87_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, -1.033, -6.3)
				arg_87_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["115001ui_story"].transform.position).z)
				arg_87_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["115001ui_story"].transform.localEulerAngles = arg_87_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["115001ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect115001ui_story == nil then
				arg_87_1.var_.characterEffect115001ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect115001ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect115001ui_story then
				arg_87_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action6_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.25

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(1105006021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 10 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 10)

				if (10 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 10)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb")

						arg_87_1:RecordAudio("1105006021", var_90_11)
						arg_87_1:RecordAudio("1105006021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006021", "story_v_side_new_1105006.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play1105006022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1105006022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1105006023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos115001ui_story = arg_91_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["115001ui_story"].transform.position).z)
				arg_91_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["115001ui_story"].transform.localEulerAngles = arg_91_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["115001ui_story"].transform.position).z)
				arg_91_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["115001ui_story"].transform.localEulerAngles = arg_91_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_94_1 = 0
			local var_94_2 = 0.625

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1105006022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 25 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 25)

				if (25 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 25)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play1105006023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1105006023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1105006024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.025

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1105006023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 41 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 41)

				if (41 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 41)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1105006024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1105006024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1105006025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.4

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1105006024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 56 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 56)

				if (56 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 56)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1105006025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1105006025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1105006026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.95

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(1105006025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 38 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 38)

				if (38 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 38)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1105006026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1105006026
		arg_107_1.duration_ = 6.67

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1105006027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos115001ui_story = arg_107_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["115001ui_story"].transform.position).z)
				arg_107_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["115001ui_story"].transform.localEulerAngles = arg_107_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, -1.033, -6.3)
				arg_107_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["115001ui_story"].transform.position).z)
				arg_107_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["115001ui_story"].transform.localEulerAngles = arg_107_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["115001ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect115001ui_story == nil then
				arg_107_1.var_.characterEffect115001ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect115001ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect115001ui_story then
				arg_107_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_110_4 = 0
			local var_110_5 = 0.6

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(1105006026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 25 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 25)

				if (25 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 25)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb")

						arg_107_1:RecordAudio("1105006026", var_110_11)
						arg_107_1:RecordAudio("1105006026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006026", "story_v_side_new_1105006.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1105006027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1105006027
		arg_111_1.duration_ = 5.67

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1105006028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0.034000001847744 < arg_111_1.time_ and arg_111_1.time_ <= 0.034000001847744 + arg_114_0 then
				local var_114_0 = arg_111_1.var_.effect2

				if not arg_111_1.var_.effect2 then
					var_114_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_114_0.name = "2"
					arg_111_1.var_.effect2 = var_114_0
				else
					var_114_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_114_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_114_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_114_2 = manager.ui.mainCamera.transform

			if 0.034000001847744 < arg_111_1.time_ and arg_111_1.time_ <= 0.034000001847744 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = var_114_2.localPosition
			end

			local var_114_3 = 0.466666666666667

			if 0.034000001847744 <= arg_111_1.time_ and arg_111_1.time_ < 0.034000001847744 + var_114_3 then
				local var_114_4, var_114_5 = math.modf((arg_111_1.time_ - 0.034000001847744) / 0.066)

				var_114_2.localPosition = Vector3.New(var_114_5 * 0.13, var_114_5 * 0.13, var_114_5 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= 0.034000001847744 + var_114_3 and arg_111_1.time_ < 0.034000001847744 + var_114_3 + arg_114_0 then
				var_114_2.localPosition = arg_111_1.var_.shakeOldPos
			end

			if 0.266666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 0.266666666666667 + arg_114_0 then
				arg_111_1:AudioAction("play", "music", "se_story_side_1050", "se_story_side_1050_bamboo3", "")

				local var_114_8 = manager.audio:GetAudioName("se_story_side_1050", "se_story_side_1050_bamboo3")

				if "" ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_8 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_8

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_8
						arg_111_1.bgmTxt2_.text = var_114_8
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_114_9 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= var_114_9 + 0.666666666666667 and arg_111_1.time_ < var_114_9 + 0.666666666666667 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_10 = arg_111_1.actors_["115001ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos115001ui_story = var_114_10.localPosition
			end

			local var_114_11 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_11 then
				var_114_10.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_11)
				var_114_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_10.position).x, (manager.ui.mainCamera.transform.position - var_114_10.position).y, (manager.ui.mainCamera.transform.position - var_114_10.position).z)
				var_114_10.localEulerAngles.z = 0
				var_114_10.localEulerAngles.x = 0
				var_114_10.localEulerAngles = var_114_10.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_11 and arg_111_1.time_ < 0 + var_114_11 + arg_114_0 then
				var_114_10.localPosition = Vector3.New(0, 100, 0)
				var_114_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_10.position).x, (manager.ui.mainCamera.transform.position - var_114_10.position).y, (manager.ui.mainCamera.transform.position - var_114_10.position).z)
				var_114_10.localEulerAngles.z = 0
				var_114_10.localEulerAngles.x = 0
				var_114_10.localEulerAngles = var_114_10.localEulerAngles
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_12 = 0.666666666666667
			local var_114_13 = 1.5

			if 0.666666666666667 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_14 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_14:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_111_1.dialogCg_.alpha = arg_116_0
				end))
				var_114_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_15 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1105006027).content)

				arg_111_1.text_.text = var_114_15

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_17 = 60 <= 0 and var_114_13 or var_114_13 * (utf8.len(var_114_15) / 60)

				if (60 <= 0 and var_114_13 or var_114_13 * (utf8.len(var_114_15) / 60)) > 0 and var_114_13 < var_114_17 then
					arg_111_1.talkMaxDuration = var_114_17
					var_114_12 = var_114_12 + 0.3

					if var_114_17 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_17 + var_114_12
					end
				end

				arg_111_1.text_.text = var_114_15
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_18 = var_114_12 + 0.3
			local var_114_19 = math.max(var_114_13, arg_111_1.talkMaxDuration)

			if var_114_12 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_18 + var_114_19 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_18) / var_114_19

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_18 + var_114_19 and arg_111_1.time_ < var_114_18 + var_114_19 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play1105006028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1105006028
		arg_118_1.duration_ = 2

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1105006029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos115001ui_story = arg_118_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["115001ui_story"].transform.position).z)
				arg_118_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["115001ui_story"].transform.localEulerAngles = arg_118_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, -1.033, -6.3)
				arg_118_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["115001ui_story"].transform.position).z)
				arg_118_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["115001ui_story"].transform.localEulerAngles = arg_118_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["115001ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect115001ui_story == nil then
				arg_118_1.var_.characterEffect115001ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect115001ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect115001ui_story then
				arg_118_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.125

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(1105006028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 5 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 5)

				if (5 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 5)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb")

						arg_118_1:RecordAudio("1105006028", var_121_11)
						arg_118_1:RecordAudio("1105006028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006028", "story_v_side_new_1105006.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play1105006029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1105006029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1105006030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos115001ui_story = arg_122_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["115001ui_story"].transform.position).z)
				arg_122_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["115001ui_story"].transform.localEulerAngles = arg_122_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["115001ui_story"].transform.position).z)
				arg_122_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["115001ui_story"].transform.localEulerAngles = arg_122_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_125_1 = 0
			local var_125_2 = 1.025

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(1105006029).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 41 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 41)

				if (41 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 41)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1105006030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1105006030
		arg_126_1.duration_ = 5.47

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1105006031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = false

				arg_126_1:SetGaussion(false)
			end

			local var_129_0 = 0.333333333333333

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				local var_129_1 = Color.New(1, 1, 1)

				var_129_1.a = Mathf.Lerp(1, 0, (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.mask_.color = var_129_1
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				local var_129_2 = Color.New(1, 1, 1)

				arg_126_1.mask_.enabled = false
				var_129_2.a = 0
				arg_126_1.mask_.color = var_129_2
			end

			if 3.4 < arg_126_1.time_ and arg_126_1.time_ <= 3.4 + arg_129_0 then
				arg_126_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_4 = 0.466666666666667
			local var_129_5 = 1.2

			if 0.466666666666667 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_6 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_6:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_7 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(1105006030).content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 48 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 48)

				if (48 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 48)) > 0 and var_129_5 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9
					var_129_4 = var_129_4 + 0.3

					if var_129_9 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = var_129_4 + 0.3
			local var_129_11 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_10) / var_129_11

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1105006031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1105006031
		arg_132_1.duration_ = 3.67

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1105006032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["115001ui_story"]) and arg_132_1.var_.characterEffect115001ui_story == nil then
				arg_132_1.var_.characterEffect115001ui_story = arg_132_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["115001ui_story"]) then
				if arg_132_1.var_.characterEffect115001ui_story and not isNil(arg_132_1.actors_["115001ui_story"]) then
					arg_132_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["115001ui_story"]) and arg_132_1.var_.characterEffect115001ui_story then
				arg_132_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_135_2 = arg_132_1.actors_["115001ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos115001ui_story = var_135_2.localPosition
			end

			local var_135_3 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 then
				var_135_2.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_132_1.time_ - 0) / var_135_3)
				var_135_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_2.position).x, (manager.ui.mainCamera.transform.position - var_135_2.position).y, (manager.ui.mainCamera.transform.position - var_135_2.position).z)
				var_135_2.localEulerAngles.z = 0
				var_135_2.localEulerAngles.x = 0
				var_135_2.localEulerAngles = var_135_2.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 then
				var_135_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_135_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_2.position).x, (manager.ui.mainCamera.transform.position - var_135_2.position).y, (manager.ui.mainCamera.transform.position - var_135_2.position).z)
				var_135_2.localEulerAngles.z = 0
				var_135_2.localEulerAngles.x = 0
				var_135_2.localEulerAngles = var_135_2.localEulerAngles
			end

			local var_135_4 = 0
			local var_135_5 = 0.4

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(1105006031)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 16 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 16)

				if (16 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 16)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb")

						arg_132_1:RecordAudio("1105006031", var_135_11)
						arg_132_1:RecordAudio("1105006031", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006031", "story_v_side_new_1105006.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play1105006032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1105006032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1105006033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos115001ui_story = arg_136_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["115001ui_story"].transform.position).z)
				arg_136_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["115001ui_story"].transform.localEulerAngles = arg_136_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["115001ui_story"].transform.position).z)
				arg_136_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["115001ui_story"].transform.localEulerAngles = arg_136_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_139_1 = 0
			local var_139_2 = 1.35

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(1105006032).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 54 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 54)

				if (54 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 54)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play1105006033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1105006033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1105006034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.125

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1105006033).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 5 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 5)

				if (5 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 5)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1105006034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1105006034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1105006035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 1

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(1105006034).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 40 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 40)

				if (40 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 40)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1105006035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1105006035
		arg_148_1.duration_ = 2

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1105006036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos115001ui_story = arg_148_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["115001ui_story"].transform.position).z)
				arg_148_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["115001ui_story"].transform.localEulerAngles = arg_148_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, -1.033, -6.3)
				arg_148_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["115001ui_story"].transform.position).z)
				arg_148_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["115001ui_story"].transform.localEulerAngles = arg_148_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["115001ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect115001ui_story == nil then
				arg_148_1.var_.characterEffect115001ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect115001ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect115001ui_story then
				arg_148_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_4 = 0
			local var_151_5 = 0.15

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(1105006035)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 6 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 6)

				if (6 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 6)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb")

						arg_148_1:RecordAudio("1105006035", var_151_11)
						arg_148_1:RecordAudio("1105006035", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006035", "story_v_side_new_1105006.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play1105006036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1105006036
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1105006037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["115001ui_story"]) and arg_152_1.var_.characterEffect115001ui_story == nil then
				arg_152_1.var_.characterEffect115001ui_story = arg_152_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["115001ui_story"]) then
				if arg_152_1.var_.characterEffect115001ui_story and not isNil(arg_152_1.actors_["115001ui_story"]) then
					arg_152_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_152_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["115001ui_story"]) and arg_152_1.var_.characterEffect115001ui_story then
				arg_152_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_152_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_155_1 = 0
			local var_155_2 = 0.4

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(1105006036).content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 16 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 16)

				if (16 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 16)) > 0 and var_155_2 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_6 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_6 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_6

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_6 and arg_152_1.time_ < var_155_1 + var_155_6 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1105006037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1105006037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1105006038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.275

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(1105006037).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 11 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 11)

				if (11 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 11)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1105006038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1105006038
		arg_160_1.duration_ = 2.5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1105006039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["115001ui_story"]) and arg_160_1.var_.characterEffect115001ui_story == nil then
				arg_160_1.var_.characterEffect115001ui_story = arg_160_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["115001ui_story"]) then
				if arg_160_1.var_.characterEffect115001ui_story and not isNil(arg_160_1.actors_["115001ui_story"]) then
					arg_160_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["115001ui_story"]) and arg_160_1.var_.characterEffect115001ui_story then
				arg_160_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_163_2 = 0
			local var_163_3 = 0.25

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(1105006038)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 10 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 10)

				if (10 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 10)) > 0 and var_163_3 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb") / 1000

					if var_163_8 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_2
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb")

						arg_160_1:RecordAudio("1105006038", var_163_9)
						arg_160_1:RecordAudio("1105006038", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006038", "story_v_side_new_1105006.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_10 and arg_160_1.time_ < var_163_2 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1105006039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1105006039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1105006040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["115001ui_story"]) and arg_164_1.var_.characterEffect115001ui_story == nil then
				arg_164_1.var_.characterEffect115001ui_story = arg_164_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["115001ui_story"]) then
				if arg_164_1.var_.characterEffect115001ui_story and not isNil(arg_164_1.actors_["115001ui_story"]) then
					arg_164_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_164_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["115001ui_story"]) and arg_164_1.var_.characterEffect115001ui_story then
				arg_164_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_164_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 1.3

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(1105006039).content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 52 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 52)

				if (52 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 52)) > 0 and var_167_2 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_6 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_6 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_6

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_6 and arg_164_1.time_ < var_167_1 + var_167_6 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1105006040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1105006040
		arg_168_1.duration_ = 6.7

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1105006041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["115001ui_story"]) and arg_168_1.var_.characterEffect115001ui_story == nil then
				arg_168_1.var_.characterEffect115001ui_story = arg_168_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["115001ui_story"]) then
				if arg_168_1.var_.characterEffect115001ui_story and not isNil(arg_168_1.actors_["115001ui_story"]) then
					arg_168_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["115001ui_story"]) and arg_168_1.var_.characterEffect115001ui_story then
				arg_168_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_171_2 = 0
			local var_171_3 = 0.9

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(1105006040)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 36 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 36)

				if (36 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 36)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb")

						arg_168_1:RecordAudio("1105006040", var_171_9)
						arg_168_1:RecordAudio("1105006040", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006040", "story_v_side_new_1105006.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1105006041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1105006041
		arg_172_1.duration_ = 6.7

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1105006042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.9

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(1105006041)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 36 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 36)

				if (36 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 36)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb")

						arg_172_1:RecordAudio("1105006041", var_175_6)
						arg_172_1:RecordAudio("1105006041", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006041", "story_v_side_new_1105006.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1105006042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1105006042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1105006043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["115001ui_story"]) and arg_176_1.var_.characterEffect115001ui_story == nil then
				arg_176_1.var_.characterEffect115001ui_story = arg_176_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["115001ui_story"]) then
				if arg_176_1.var_.characterEffect115001ui_story and not isNil(arg_176_1.actors_["115001ui_story"]) then
					arg_176_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_176_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["115001ui_story"]) and arg_176_1.var_.characterEffect115001ui_story then
				arg_176_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_176_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_179_1 = 0
			local var_179_2 = 0.975

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(1105006042).content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 39 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 39)

				if (39 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 39)) > 0 and var_179_2 < var_179_5 then
					arg_176_1.talkMaxDuration = var_179_5

					if var_179_5 + var_179_1 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + var_179_1
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_6 = math.max(var_179_2, arg_176_1.talkMaxDuration)

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_6 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_1) / var_179_6

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_1 + var_179_6 and arg_176_1.time_ < var_179_1 + var_179_6 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1105006043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1105006043
		arg_180_1.duration_ = 2.63

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1105006044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["115001ui_story"]) and arg_180_1.var_.characterEffect115001ui_story == nil then
				arg_180_1.var_.characterEffect115001ui_story = arg_180_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["115001ui_story"]) then
				if arg_180_1.var_.characterEffect115001ui_story and not isNil(arg_180_1.actors_["115001ui_story"]) then
					arg_180_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["115001ui_story"]) and arg_180_1.var_.characterEffect115001ui_story then
				arg_180_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_183_2 = 0
			local var_183_3 = 0.325

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_4 = arg_180_1:GetWordFromCfg(1105006043)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 13 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 13)

				if (13 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 13)) > 0 and var_183_3 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb") / 1000

					if var_183_8 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_2
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb")

						arg_180_1:RecordAudio("1105006043", var_183_9)
						arg_180_1:RecordAudio("1105006043", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006043", "story_v_side_new_1105006.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_10 and arg_180_1.time_ < var_183_2 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1105006044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1105006044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1105006045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["115001ui_story"]) and arg_184_1.var_.characterEffect115001ui_story == nil then
				arg_184_1.var_.characterEffect115001ui_story = arg_184_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["115001ui_story"]) then
				if arg_184_1.var_.characterEffect115001ui_story and not isNil(arg_184_1.actors_["115001ui_story"]) then
					arg_184_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_184_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["115001ui_story"]) and arg_184_1.var_.characterEffect115001ui_story then
				arg_184_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_184_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.65

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(1105006044).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 26 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 26)

				if (26 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 26)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1105006045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1105006045
		arg_188_1.duration_ = 2

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1105006046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["115001ui_story"]) and arg_188_1.var_.characterEffect115001ui_story == nil then
				arg_188_1.var_.characterEffect115001ui_story = arg_188_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["115001ui_story"]) then
				if arg_188_1.var_.characterEffect115001ui_story and not isNil(arg_188_1.actors_["115001ui_story"]) then
					arg_188_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["115001ui_story"]) and arg_188_1.var_.characterEffect115001ui_story then
				arg_188_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_191_2 = 0
			local var_191_3 = 0.1

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:GetWordFromCfg(1105006045)
				local var_191_5 = arg_188_1:FormatText(var_191_4.content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 4 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 4)

				if (4 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 4)) > 0 and var_191_3 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb") / 1000

					if var_191_8 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_2
					end

					if var_191_4.prefab_name ~= "" and arg_188_1.actors_[var_191_4.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_4.prefab_name].transform, "story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb")

						arg_188_1:RecordAudio("1105006045", var_191_9)
						arg_188_1:RecordAudio("1105006045", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006045", "story_v_side_new_1105006.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_10 and arg_188_1.time_ < var_191_2 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1105006046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1105006046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1105006047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos115001ui_story = arg_192_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_195_0 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 then
				arg_192_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_0)
				arg_192_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["115001ui_story"].transform.position).z)
				arg_192_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["115001ui_story"].transform.localEulerAngles = arg_192_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 then
				arg_192_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["115001ui_story"].transform.position).z)
				arg_192_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["115001ui_story"].transform.localEulerAngles = arg_192_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_195_1 = 0
			local var_195_2 = 0.8

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(1105006046).content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 32 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 32)

				if (32 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 32)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_6 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_6 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_6

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_6 and arg_192_1.time_ < var_195_1 + var_195_6 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play1105006047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1105006047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1105006048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.925

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(1105006047).content)

				arg_196_1.text_.text = var_199_1

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_3 = 37 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 37)

				if (37 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 37)) > 0 and var_199_0 < var_199_3 then
					arg_196_1.talkMaxDuration = var_199_3

					if var_199_3 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_3 + 0
					end
				end

				arg_196_1.text_.text = var_199_1
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_4 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_4

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1105006048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1105006048
		arg_200_1.duration_ = 5.13

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1105006049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["115001ui_story"]) and arg_200_1.var_.characterEffect115001ui_story == nil then
				arg_200_1.var_.characterEffect115001ui_story = arg_200_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["115001ui_story"]) then
				if arg_200_1.var_.characterEffect115001ui_story and not isNil(arg_200_1.actors_["115001ui_story"]) then
					arg_200_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["115001ui_story"]) and arg_200_1.var_.characterEffect115001ui_story then
				arg_200_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_203_2 = arg_200_1.actors_["115001ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos115001ui_story = var_203_2.localPosition
			end

			local var_203_3 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 then
				var_203_2.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_200_1.time_ - 0) / var_203_3)
				var_203_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_2.position).x, (manager.ui.mainCamera.transform.position - var_203_2.position).y, (manager.ui.mainCamera.transform.position - var_203_2.position).z)
				var_203_2.localEulerAngles.z = 0
				var_203_2.localEulerAngles.x = 0
				var_203_2.localEulerAngles = var_203_2.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 then
				var_203_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_203_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_2.position).x, (manager.ui.mainCamera.transform.position - var_203_2.position).y, (manager.ui.mainCamera.transform.position - var_203_2.position).z)
				var_203_2.localEulerAngles.z = 0
				var_203_2.localEulerAngles.x = 0
				var_203_2.localEulerAngles = var_203_2.localEulerAngles
			end

			local var_203_4 = 0
			local var_203_5 = 0.475

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(1105006048)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 19 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 19)

				if (19 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 19)) > 0 and var_203_5 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb") / 1000

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end

					if var_203_6.prefab_name ~= "" and arg_200_1.actors_[var_203_6.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_6.prefab_name].transform, "story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb")

						arg_200_1:RecordAudio("1105006048", var_203_11)
						arg_200_1:RecordAudio("1105006048", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006048", "story_v_side_new_1105006.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_12 and arg_200_1.time_ < var_203_4 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play1105006049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1105006049
		arg_204_1.duration_ = 8.73

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1105006050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.9

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(1105006049)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 36 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 36)

				if (36 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 36)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb")

						arg_204_1:RecordAudio("1105006049", var_207_6)
						arg_204_1:RecordAudio("1105006049", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006049", "story_v_side_new_1105006.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1105006050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1105006050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1105006051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["115001ui_story"]) and arg_208_1.var_.characterEffect115001ui_story == nil then
				arg_208_1.var_.characterEffect115001ui_story = arg_208_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["115001ui_story"]) then
				if arg_208_1.var_.characterEffect115001ui_story and not isNil(arg_208_1.actors_["115001ui_story"]) then
					arg_208_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_208_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["115001ui_story"]) and arg_208_1.var_.characterEffect115001ui_story then
				arg_208_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_208_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 1.225

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(1105006050).content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 49 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 49)

				if (49 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 49)) > 0 and var_211_2 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_6 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_6 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_6

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_6 and arg_208_1.time_ < var_211_1 + var_211_6 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1105006051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1105006051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1105006052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 1.05

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_1 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(1105006051).content)

				arg_212_1.text_.text = var_215_1

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_3 = 42 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 42)

				if (42 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 42)) > 0 and var_215_0 < var_215_3 then
					arg_212_1.talkMaxDuration = var_215_3

					if var_215_3 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_3 + 0
					end
				end

				arg_212_1.text_.text = var_215_1
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_4 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_4

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1105006052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1105006052
		arg_216_1.duration_ = 3.17

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1105006053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["115001ui_story"]) and arg_216_1.var_.characterEffect115001ui_story == nil then
				arg_216_1.var_.characterEffect115001ui_story = arg_216_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["115001ui_story"]) then
				if arg_216_1.var_.characterEffect115001ui_story and not isNil(arg_216_1.actors_["115001ui_story"]) then
					arg_216_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["115001ui_story"]) and arg_216_1.var_.characterEffect115001ui_story then
				arg_216_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_219_2 = 0
			local var_219_3 = 0.325

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_4 = arg_216_1:GetWordFromCfg(1105006052)
				local var_219_5 = arg_216_1:FormatText(var_219_4.content)

				arg_216_1.text_.text = var_219_5

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_7 = 13 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 13)

				if (13 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 13)) > 0 and var_219_3 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_5
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb") / 1000

					if var_219_8 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_2
					end

					if var_219_4.prefab_name ~= "" and arg_216_1.actors_[var_219_4.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_4.prefab_name].transform, "story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb")

						arg_216_1:RecordAudio("1105006052", var_219_9)
						arg_216_1:RecordAudio("1105006052", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006052", "story_v_side_new_1105006.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_2) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_2 + var_219_10 and arg_216_1.time_ < var_219_2 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1105006053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1105006053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1105006054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["115001ui_story"]) and arg_220_1.var_.characterEffect115001ui_story == nil then
				arg_220_1.var_.characterEffect115001ui_story = arg_220_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["115001ui_story"]) then
				if arg_220_1.var_.characterEffect115001ui_story and not isNil(arg_220_1.actors_["115001ui_story"]) then
					arg_220_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_220_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_0)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["115001ui_story"]) and arg_220_1.var_.characterEffect115001ui_story then
				arg_220_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_220_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_223_1 = 0
			local var_223_2 = 0.25

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(1105006053).content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 10 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 10)

				if (10 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 10)) > 0 and var_223_2 < var_223_5 then
					arg_220_1.talkMaxDuration = var_223_5

					if var_223_5 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + var_223_1
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_6 = math.max(var_223_2, arg_220_1.talkMaxDuration)

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_6 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_1) / var_223_6

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_1 + var_223_6 and arg_220_1.time_ < var_223_1 + var_223_6 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1105006054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1105006054
		arg_224_1.duration_ = 1

		SetActive(arg_224_1.tipsGo_, true)

		arg_224_1.tipsText_.text = StoryTipsCfg[105001].name

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"

			SetActive(arg_224_1.choicesGo_, true)

			for iter_225_0, iter_225_1 in ipairs(arg_224_1.choices_) do
				SetActive(iter_225_1.go, iter_225_0 <= 2)
			end

			arg_224_1.choices_[1].txt.text = arg_224_1:FormatText(StoryChoiceCfg[1064].name)
			arg_224_1.choices_[2].txt.text = arg_224_1:FormatText(StoryChoiceCfg[1065].name)
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				PlayerAction.UseStoryTrigger(1050012, 210500106, 1105006054, 1)
				arg_224_0:Play1105006055(arg_224_1)
			end

			if arg_226_0 == 2 then
				arg_224_0:Play1105006057(arg_224_1)
			end

			arg_224_1:RecordChoiceLog(1105006054, 1064, 1065)
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			return
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play1105006055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1105006055
		arg_228_1.duration_ = 5.5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1105006056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["115001ui_story"]) and arg_228_1.var_.characterEffect115001ui_story == nil then
				arg_228_1.var_.characterEffect115001ui_story = arg_228_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["115001ui_story"]) then
				if arg_228_1.var_.characterEffect115001ui_story and not isNil(arg_228_1.actors_["115001ui_story"]) then
					arg_228_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["115001ui_story"]) and arg_228_1.var_.characterEffect115001ui_story then
				arg_228_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_231_2 = 0
			local var_231_3 = 0.35

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_4 = arg_228_1:GetWordFromCfg(1105006055)
				local var_231_5 = arg_228_1:FormatText(var_231_4.content)

				arg_228_1.text_.text = var_231_5

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_7 = 14 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 14)

				if (14 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 14)) > 0 and var_231_3 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_2
					end
				end

				arg_228_1.text_.text = var_231_5
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb") / 1000

					if var_231_8 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_2
					end

					if var_231_4.prefab_name ~= "" and arg_228_1.actors_[var_231_4.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_4.prefab_name].transform, "story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb")

						arg_228_1:RecordAudio("1105006055", var_231_9)
						arg_228_1:RecordAudio("1105006055", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006055", "story_v_side_new_1105006.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_3, arg_228_1.talkMaxDuration)

			if var_231_2 <= arg_228_1.time_ and arg_228_1.time_ < var_231_2 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_2) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_2 + var_231_10 and arg_228_1.time_ < var_231_2 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1105006056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1105006056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1105006057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos115001ui_story = arg_232_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["115001ui_story"].transform.position).z)
				arg_232_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["115001ui_story"].transform.localEulerAngles = arg_232_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["115001ui_story"].transform.position).z)
				arg_232_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["115001ui_story"].transform.localEulerAngles = arg_232_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_235_1 = 0
			local var_235_2 = 0.225

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(1105006056).content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 9 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 9)

				if (9 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 9)) > 0 and var_235_2 < var_235_5 then
					arg_232_1.talkMaxDuration = var_235_5

					if var_235_5 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_6 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_6 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_6

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_6 and arg_232_1.time_ < var_235_1 + var_235_6 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play1105006057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1105006057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1105006058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos115001ui_story = arg_236_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["115001ui_story"].transform.position).z)
				arg_236_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["115001ui_story"].transform.localEulerAngles = arg_236_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["115001ui_story"].transform.position).z)
				arg_236_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["115001ui_story"].transform.localEulerAngles = arg_236_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_239_1 = 0
			local var_239_2 = 0.45

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(1105006057).content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 18 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 18)

				if (18 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 18)) > 0 and var_239_2 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_1 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_1
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_6 = math.max(var_239_2, arg_236_1.talkMaxDuration)

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_6 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_1) / var_239_6

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_1 + var_239_6 and arg_236_1.time_ < var_239_1 + var_239_6 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play1105006058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1105006058
		arg_240_1.duration_ = 2.67

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1105006059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["115001ui_story"]) and arg_240_1.var_.characterEffect115001ui_story == nil then
				arg_240_1.var_.characterEffect115001ui_story = arg_240_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["115001ui_story"]) then
				if arg_240_1.var_.characterEffect115001ui_story and not isNil(arg_240_1.actors_["115001ui_story"]) then
					arg_240_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["115001ui_story"]) and arg_240_1.var_.characterEffect115001ui_story then
				arg_240_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_243_2 = arg_240_1.actors_["115001ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos115001ui_story = var_243_2.localPosition
			end

			local var_243_3 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 then
				var_243_2.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_240_1.time_ - 0) / var_243_3)
				var_243_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_2.position).x, (manager.ui.mainCamera.transform.position - var_243_2.position).y, (manager.ui.mainCamera.transform.position - var_243_2.position).z)
				var_243_2.localEulerAngles.z = 0
				var_243_2.localEulerAngles.x = 0
				var_243_2.localEulerAngles = var_243_2.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 then
				var_243_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_243_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_2.position).x, (manager.ui.mainCamera.transform.position - var_243_2.position).y, (manager.ui.mainCamera.transform.position - var_243_2.position).z)
				var_243_2.localEulerAngles.z = 0
				var_243_2.localEulerAngles.x = 0
				var_243_2.localEulerAngles = var_243_2.localEulerAngles
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_243_4 = 0
			local var_243_5 = 0.375

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_6 = arg_240_1:GetWordFromCfg(1105006058)
				local var_243_7 = arg_240_1:FormatText(var_243_6.content)

				arg_240_1.text_.text = var_243_7

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 15 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 15)

				if (15 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 15)) > 0 and var_243_5 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_4
					end
				end

				arg_240_1.text_.text = var_243_7
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb") / 1000

					if var_243_10 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_4
					end

					if var_243_6.prefab_name ~= "" and arg_240_1.actors_[var_243_6.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_6.prefab_name].transform, "story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb")

						arg_240_1:RecordAudio("1105006058", var_243_11)
						arg_240_1:RecordAudio("1105006058", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006058", "story_v_side_new_1105006.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_12 = math.max(var_243_5, arg_240_1.talkMaxDuration)

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_12 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_4) / var_243_12

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_4 + var_243_12 and arg_240_1.time_ < var_243_4 + var_243_12 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play1105006059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1105006059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1105006060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos115001ui_story = arg_244_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["115001ui_story"].transform.position).z)
				arg_244_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["115001ui_story"].transform.localEulerAngles = arg_244_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["115001ui_story"].transform.position).z)
				arg_244_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["115001ui_story"].transform.localEulerAngles = arg_244_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_247_1 = 0
			local var_247_2 = 0.975

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(1105006059).content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 39 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 39)

				if (39 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 39)) > 0 and var_247_2 < var_247_5 then
					arg_244_1.talkMaxDuration = var_247_5

					if var_247_5 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_6 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_6 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_6

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_6 and arg_244_1.time_ < var_247_1 + var_247_6 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play1105006060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1105006060
		arg_248_1.duration_ = 2

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1105006061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["115001ui_story"]) and arg_248_1.var_.characterEffect115001ui_story == nil then
				arg_248_1.var_.characterEffect115001ui_story = arg_248_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["115001ui_story"]) then
				if arg_248_1.var_.characterEffect115001ui_story and not isNil(arg_248_1.actors_["115001ui_story"]) then
					arg_248_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["115001ui_story"]) and arg_248_1.var_.characterEffect115001ui_story then
				arg_248_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_251_2 = arg_248_1.actors_["115001ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos115001ui_story = var_251_2.localPosition
			end

			local var_251_3 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_3 then
				var_251_2.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_248_1.time_ - 0) / var_251_3)
				var_251_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_2.position).x, (manager.ui.mainCamera.transform.position - var_251_2.position).y, (manager.ui.mainCamera.transform.position - var_251_2.position).z)
				var_251_2.localEulerAngles.z = 0
				var_251_2.localEulerAngles.x = 0
				var_251_2.localEulerAngles = var_251_2.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_3 and arg_248_1.time_ < 0 + var_251_3 + arg_251_0 then
				var_251_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_251_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_2.position).x, (manager.ui.mainCamera.transform.position - var_251_2.position).y, (manager.ui.mainCamera.transform.position - var_251_2.position).z)
				var_251_2.localEulerAngles.z = 0
				var_251_2.localEulerAngles.x = 0
				var_251_2.localEulerAngles = var_251_2.localEulerAngles
			end

			local var_251_4 = 0
			local var_251_5 = 0.125

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_6 = arg_248_1:GetWordFromCfg(1105006060)
				local var_251_7 = arg_248_1:FormatText(var_251_6.content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 5 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 5)

				if (5 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 5)) > 0 and var_251_5 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb") ~= 0 then
					local var_251_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb") / 1000

					if var_251_10 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_4
					end

					if var_251_6.prefab_name ~= "" and arg_248_1.actors_[var_251_6.prefab_name] ~= nil then
						local var_251_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_6.prefab_name].transform, "story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb")

						arg_248_1:RecordAudio("1105006060", var_251_11)
						arg_248_1:RecordAudio("1105006060", var_251_11)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006060", "story_v_side_new_1105006.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_12 and arg_248_1.time_ < var_251_4 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play1105006061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1105006061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1105006062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["115001ui_story"]) and arg_252_1.var_.characterEffect115001ui_story == nil then
				arg_252_1.var_.characterEffect115001ui_story = arg_252_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["115001ui_story"]) then
				if arg_252_1.var_.characterEffect115001ui_story and not isNil(arg_252_1.actors_["115001ui_story"]) then
					arg_252_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_252_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["115001ui_story"]) and arg_252_1.var_.characterEffect115001ui_story then
				arg_252_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_252_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_255_1 = 0
			local var_255_2 = 0.25

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(1105006061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 10 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 10)

				if (10 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 10)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1105006062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1105006062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1105006063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 1.3

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(1105006062).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 52 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 52)

				if (52 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 52)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1105006063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1105006063
		arg_260_1.duration_ = 4.93

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1105006064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["115001ui_story"]) and arg_260_1.var_.characterEffect115001ui_story == nil then
				arg_260_1.var_.characterEffect115001ui_story = arg_260_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["115001ui_story"]) then
				if arg_260_1.var_.characterEffect115001ui_story and not isNil(arg_260_1.actors_["115001ui_story"]) then
					arg_260_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["115001ui_story"]) and arg_260_1.var_.characterEffect115001ui_story then
				arg_260_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_263_2 = 0
			local var_263_3 = 0.675

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_4 = arg_260_1:GetWordFromCfg(1105006063)
				local var_263_5 = arg_260_1:FormatText(var_263_4.content)

				arg_260_1.text_.text = var_263_5

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_7 = 27 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 27)

				if (27 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 27)) > 0 and var_263_3 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_2
					end
				end

				arg_260_1.text_.text = var_263_5
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb") / 1000

					if var_263_8 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_2
					end

					if var_263_4.prefab_name ~= "" and arg_260_1.actors_[var_263_4.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_4.prefab_name].transform, "story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb")

						arg_260_1:RecordAudio("1105006063", var_263_9)
						arg_260_1:RecordAudio("1105006063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006063", "story_v_side_new_1105006.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_3, arg_260_1.talkMaxDuration)

			if var_263_2 <= arg_260_1.time_ and arg_260_1.time_ < var_263_2 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_2) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_2 + var_263_10 and arg_260_1.time_ < var_263_2 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1105006064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1105006064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1105006065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos115001ui_story = arg_264_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["115001ui_story"].transform.position).z)
				arg_264_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["115001ui_story"].transform.localEulerAngles = arg_264_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["115001ui_story"].transform.position).z)
				arg_264_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["115001ui_story"].transform.localEulerAngles = arg_264_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_267_1 = 0
			local var_267_2 = 0.35

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(1105006064).content)

				arg_264_1.text_.text = var_267_3

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 14 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 14)

				if (14 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 14)) > 0 and var_267_2 < var_267_5 then
					arg_264_1.talkMaxDuration = var_267_5

					if var_267_5 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + var_267_1
					end
				end

				arg_264_1.text_.text = var_267_3
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_6 = math.max(var_267_2, arg_264_1.talkMaxDuration)

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_6 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_1) / var_267_6

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_1 + var_267_6 and arg_264_1.time_ < var_267_1 + var_267_6 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play1105006065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1105006065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1105006066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.4

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(1105006065).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 16 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 16)

				if (16 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 16)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1105006066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1105006066
		arg_272_1.duration_ = 7.33

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1105006067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["115001ui_story"]) and arg_272_1.var_.characterEffect115001ui_story == nil then
				arg_272_1.var_.characterEffect115001ui_story = arg_272_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["115001ui_story"]) then
				if arg_272_1.var_.characterEffect115001ui_story and not isNil(arg_272_1.actors_["115001ui_story"]) then
					arg_272_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["115001ui_story"]) and arg_272_1.var_.characterEffect115001ui_story then
				arg_272_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_275_2 = arg_272_1.actors_["115001ui_story"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos115001ui_story = var_275_2.localPosition
			end

			local var_275_3 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_3 then
				var_275_2.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_272_1.time_ - 0) / var_275_3)
				var_275_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_2.position).x, (manager.ui.mainCamera.transform.position - var_275_2.position).y, (manager.ui.mainCamera.transform.position - var_275_2.position).z)
				var_275_2.localEulerAngles.z = 0
				var_275_2.localEulerAngles.x = 0
				var_275_2.localEulerAngles = var_275_2.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_3 and arg_272_1.time_ < 0 + var_275_3 + arg_275_0 then
				var_275_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_275_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_2.position).x, (manager.ui.mainCamera.transform.position - var_275_2.position).y, (manager.ui.mainCamera.transform.position - var_275_2.position).z)
				var_275_2.localEulerAngles.z = 0
				var_275_2.localEulerAngles.x = 0
				var_275_2.localEulerAngles = var_275_2.localEulerAngles
			end

			local var_275_4 = 0
			local var_275_5 = 0.625

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:GetWordFromCfg(1105006066)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 25 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 25)

				if (25 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 25)) > 0 and var_275_5 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb") / 1000

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb")

						arg_272_1:RecordAudio("1105006066", var_275_11)
						arg_272_1:RecordAudio("1105006066", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006066", "story_v_side_new_1105006.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_12 and arg_272_1.time_ < var_275_4 + var_275_12 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play1105006067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1105006067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1105006068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["115001ui_story"]) and arg_276_1.var_.characterEffect115001ui_story == nil then
				arg_276_1.var_.characterEffect115001ui_story = arg_276_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["115001ui_story"]) then
				if arg_276_1.var_.characterEffect115001ui_story and not isNil(arg_276_1.actors_["115001ui_story"]) then
					arg_276_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_276_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["115001ui_story"]) and arg_276_1.var_.characterEffect115001ui_story then
				arg_276_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_276_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.2

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(1105006067).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 8 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 8)

				if (8 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 8)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1105006068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1105006068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1105006069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["115001ui_story"]) and arg_280_1.var_.characterEffect115001ui_story == nil then
				arg_280_1.var_.characterEffect115001ui_story = arg_280_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.095033198595047

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["115001ui_story"]) then
				if arg_280_1.var_.characterEffect115001ui_story and not isNil(arg_280_1.actors_["115001ui_story"]) then
					arg_280_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_280_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["115001ui_story"]) and arg_280_1.var_.characterEffect115001ui_story then
				arg_280_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_280_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 1

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(1105006068).content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 40 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 40)

				if (40 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 40)) > 0 and var_283_2 < var_283_5 then
					arg_280_1.talkMaxDuration = var_283_5

					if var_283_5 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_6 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_6 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_6

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_6 and arg_280_1.time_ < var_283_1 + var_283_6 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1105006069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1105006069
		arg_284_1.duration_ = 5.87

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1105006070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["115001ui_story"]) and arg_284_1.var_.characterEffect115001ui_story == nil then
				arg_284_1.var_.characterEffect115001ui_story = arg_284_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["115001ui_story"]) then
				if arg_284_1.var_.characterEffect115001ui_story and not isNil(arg_284_1.actors_["115001ui_story"]) then
					arg_284_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["115001ui_story"]) and arg_284_1.var_.characterEffect115001ui_story then
				arg_284_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_287_2 = 0
			local var_287_3 = 0.45

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_4 = arg_284_1:GetWordFromCfg(1105006069)
				local var_287_5 = arg_284_1:FormatText(var_287_4.content)

				arg_284_1.text_.text = var_287_5

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 18 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 18)

				if (18 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 18)) > 0 and var_287_3 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_5
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb") / 1000

					if var_287_8 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_2
					end

					if var_287_4.prefab_name ~= "" and arg_284_1.actors_[var_287_4.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_4.prefab_name].transform, "story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb")

						arg_284_1:RecordAudio("1105006069", var_287_9)
						arg_284_1:RecordAudio("1105006069", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006069", "story_v_side_new_1105006.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 <= arg_284_1.time_ and arg_284_1.time_ < var_287_2 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_2) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_2 + var_287_10 and arg_284_1.time_ < var_287_2 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1105006070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1105006070
		arg_288_1.duration_ = 7.17

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1105006071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["115001ui_story"]) and arg_288_1.var_.characterEffect115001ui_story == nil then
				arg_288_1.var_.characterEffect115001ui_story = arg_288_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["115001ui_story"]) then
				if arg_288_1.var_.characterEffect115001ui_story and not isNil(arg_288_1.actors_["115001ui_story"]) then
					arg_288_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["115001ui_story"]) and arg_288_1.var_.characterEffect115001ui_story then
				arg_288_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_291_2 = 0
			local var_291_3 = 1.05

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_4 = arg_288_1:GetWordFromCfg(1105006070)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 42 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 42)

				if (42 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 42)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb")

						arg_288_1:RecordAudio("1105006070", var_291_9)
						arg_288_1:RecordAudio("1105006070", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006070", "story_v_side_new_1105006.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1105006071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1105006071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1105006072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["115001ui_story"]) and arg_292_1.var_.characterEffect115001ui_story == nil then
				arg_292_1.var_.characterEffect115001ui_story = arg_292_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["115001ui_story"]) then
				if arg_292_1.var_.characterEffect115001ui_story and not isNil(arg_292_1.actors_["115001ui_story"]) then
					arg_292_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_292_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_0)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["115001ui_story"]) and arg_292_1.var_.characterEffect115001ui_story then
				arg_292_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_292_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_295_1 = 0
			local var_295_2 = 0.075

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(1105006071).content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 3 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 3)

				if (3 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 3)) > 0 and var_295_2 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_1
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_6 = math.max(var_295_2, arg_292_1.talkMaxDuration)

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_6 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_1) / var_295_6

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_1 + var_295_6 and arg_292_1.time_ < var_295_1 + var_295_6 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1105006072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1105006072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1105006073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos115001ui_story = arg_296_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["115001ui_story"].transform.position).z)
				arg_296_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["115001ui_story"].transform.localEulerAngles = arg_296_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["115001ui_story"].transform.position).z)
				arg_296_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["115001ui_story"].transform.localEulerAngles = arg_296_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_299_1 = 0
			local var_299_2 = 0.35

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(1105006072).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 14 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 14)

				if (14 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 14)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1105006073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1105006073
		arg_300_1.duration_ = 3.4

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1105006074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["115001ui_story"]) and arg_300_1.var_.characterEffect115001ui_story == nil then
				arg_300_1.var_.characterEffect115001ui_story = arg_300_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["115001ui_story"]) then
				if arg_300_1.var_.characterEffect115001ui_story and not isNil(arg_300_1.actors_["115001ui_story"]) then
					arg_300_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["115001ui_story"]) and arg_300_1.var_.characterEffect115001ui_story then
				arg_300_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_303_2 = arg_300_1.actors_["115001ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos115001ui_story = var_303_2.localPosition
			end

			local var_303_3 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_3 then
				var_303_2.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_300_1.time_ - 0) / var_303_3)
				var_303_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_2.position).x, (manager.ui.mainCamera.transform.position - var_303_2.position).y, (manager.ui.mainCamera.transform.position - var_303_2.position).z)
				var_303_2.localEulerAngles.z = 0
				var_303_2.localEulerAngles.x = 0
				var_303_2.localEulerAngles = var_303_2.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_3 and arg_300_1.time_ < 0 + var_303_3 + arg_303_0 then
				var_303_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_303_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_2.position).x, (manager.ui.mainCamera.transform.position - var_303_2.position).y, (manager.ui.mainCamera.transform.position - var_303_2.position).z)
				var_303_2.localEulerAngles.z = 0
				var_303_2.localEulerAngles.x = 0
				var_303_2.localEulerAngles = var_303_2.localEulerAngles
			end

			local var_303_4 = 0
			local var_303_5 = 0.4

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_6 = arg_300_1:GetWordFromCfg(1105006073)
				local var_303_7 = arg_300_1:FormatText(var_303_6.content)

				arg_300_1.text_.text = var_303_7

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_9 = 16 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_7) / 16)

				if (16 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_7) / 16)) > 0 and var_303_5 < var_303_9 then
					arg_300_1.talkMaxDuration = var_303_9

					if var_303_9 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_9 + var_303_4
					end
				end

				arg_300_1.text_.text = var_303_7
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb") ~= 0 then
					local var_303_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb") / 1000

					if var_303_10 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_4
					end

					if var_303_6.prefab_name ~= "" and arg_300_1.actors_[var_303_6.prefab_name] ~= nil then
						local var_303_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_6.prefab_name].transform, "story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb")

						arg_300_1:RecordAudio("1105006073", var_303_11)
						arg_300_1:RecordAudio("1105006073", var_303_11)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006073", "story_v_side_new_1105006.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_12 = math.max(var_303_5, arg_300_1.talkMaxDuration)

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_12 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_4) / var_303_12

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_4 + var_303_12 and arg_300_1.time_ < var_303_4 + var_303_12 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1105006074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1105006074
		arg_304_1.duration_ = 9

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1105006075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if arg_304_1.bgs_.ST11 == nil then
				local var_307_0 = Object.Instantiate(arg_304_1.paintGo_)

				var_307_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST11")
				var_307_0.name = "ST11"
				var_307_0.transform.parent = arg_304_1.stage_.transform
				var_307_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.bgs_.ST11 = var_307_0
			end

			if 2 < arg_304_1.time_ and arg_304_1.time_ <= 2 + arg_307_0 then
				local var_307_1 = arg_304_1.bgs_.ST11

				arg_304_1.bgs_.ST11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_307_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_307_2 = var_307_1:GetComponent("SpriteRenderer")

				if var_307_2 and var_307_2.sprite then
					local var_307_3 = 2 * (var_307_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_307_1.transform.localScale = Vector3.New(var_307_3 / var_307_2.sprite.bounds.size.y < var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x and var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x or var_307_3 / var_307_2.sprite.bounds.size.y, var_307_3 / var_307_2.sprite.bounds.size.y < var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x and var_307_3 * manager.ui.mainCameraCom_.aspect / var_307_2.sprite.bounds.size.x or var_307_3 / var_307_2.sprite.bounds.size.y, 0)
				end

				for iter_307_0, iter_307_1 in pairs(arg_304_1.bgs_) do
					if iter_307_0 ~= "ST11" then
						iter_307_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_307_4 = 3.999999999999

			if 3.999999999999 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.allBtn_.enabled = false
			end

			if arg_304_1.time_ >= var_307_4 + 0.3 and arg_304_1.time_ < var_307_4 + 0.3 + arg_307_0 then
				arg_304_1.allBtn_.enabled = true
			end

			local var_307_5 = 0

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_6 = 2

			if var_307_5 <= arg_304_1.time_ and arg_304_1.time_ < var_307_5 + var_307_6 then
				local var_307_7 = Color.New(0, 0, 0)

				var_307_7.a = Mathf.Lerp(0, 1, (arg_304_1.time_ - var_307_5) / var_307_6)
				arg_304_1.mask_.color = var_307_7
			end

			if arg_304_1.time_ >= var_307_5 + var_307_6 and arg_304_1.time_ < var_307_5 + var_307_6 + arg_307_0 then
				local var_307_8 = Color.New(0, 0, 0)

				var_307_8.a = 1
				arg_304_1.mask_.color = var_307_8
			end

			local var_307_9 = 1.999999999999

			if 1.999999999999 < arg_304_1.time_ and arg_304_1.time_ <= var_307_9 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_10 = 2

			if var_307_9 <= arg_304_1.time_ and arg_304_1.time_ < var_307_9 + var_307_10 then
				local var_307_11 = Color.New(0, 0, 0)

				var_307_11.a = Mathf.Lerp(1, 0, (arg_304_1.time_ - var_307_9) / var_307_10)
				arg_304_1.mask_.color = var_307_11
			end

			if arg_304_1.time_ >= var_307_9 + var_307_10 and arg_304_1.time_ < var_307_9 + var_307_10 + arg_307_0 then
				local var_307_12 = Color.New(0, 0, 0)

				arg_304_1.mask_.enabled = false
				var_307_12.a = 0
				arg_304_1.mask_.color = var_307_12
			end

			local var_307_13 = arg_304_1.actors_["115001ui_story"].transform

			if 1.96599999815126 < arg_304_1.time_ and arg_304_1.time_ <= 1.96599999815126 + arg_307_0 then
				arg_304_1.var_.moveOldPos115001ui_story = var_307_13.localPosition
			end

			local var_307_14 = 0.001

			if 1.96599999815126 <= arg_304_1.time_ and arg_304_1.time_ < 1.96599999815126 + var_307_14 then
				var_307_13.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_304_1.time_ - 1.96599999815126) / var_307_14)
				var_307_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_13.position).x, (manager.ui.mainCamera.transform.position - var_307_13.position).y, (manager.ui.mainCamera.transform.position - var_307_13.position).z)
				var_307_13.localEulerAngles.z = 0
				var_307_13.localEulerAngles.x = 0
				var_307_13.localEulerAngles = var_307_13.localEulerAngles
			end

			if arg_304_1.time_ >= 1.96599999815126 + var_307_14 and arg_304_1.time_ < 1.96599999815126 + var_307_14 + arg_307_0 then
				var_307_13.localPosition = Vector3.New(0, 100, 0)
				var_307_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_13.position).x, (manager.ui.mainCamera.transform.position - var_307_13.position).y, (manager.ui.mainCamera.transform.position - var_307_13.position).z)
				var_307_13.localEulerAngles.z = 0
				var_307_13.localEulerAngles.x = 0
				var_307_13.localEulerAngles = var_307_13.localEulerAngles
			end

			if arg_304_1.frameCnt_ <= 1 then
				arg_304_1.dialog_:SetActive(false)
			end

			local var_307_15 = 3.999999999999
			local var_307_16 = 0.65

			if 3.999999999999 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				arg_304_1.dialog_:SetActive(true)

				arg_304_1.dialogCg_.alpha = 0

				local var_307_17 = LeanTween.value(arg_304_1.dialog_, 0, 1, 0.3)

				var_307_17:setOnUpdate(LuaHelper.FloatAction(function(arg_308_0)
					arg_304_1.dialogCg_.alpha = arg_308_0
				end))
				var_307_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_304_1.dialog_)
					var_307_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_304_1.duration_ = arg_304_1.duration_ + 0.3

				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_18 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(1105006074).content)

				arg_304_1.text_.text = var_307_18

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_20 = 26 <= 0 and var_307_16 or var_307_16 * (utf8.len(var_307_18) / 26)

				if (26 <= 0 and var_307_16 or var_307_16 * (utf8.len(var_307_18) / 26)) > 0 and var_307_16 < var_307_20 then
					arg_304_1.talkMaxDuration = var_307_20
					var_307_15 = var_307_15 + 0.3

					if var_307_20 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_20 + var_307_15
					end
				end

				arg_304_1.text_.text = var_307_18
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_21 = var_307_15 + 0.3
			local var_307_22 = math.max(var_307_16, arg_304_1.talkMaxDuration)

			if var_307_15 + 0.3 <= arg_304_1.time_ and arg_304_1.time_ < var_307_21 + var_307_22 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_21) / var_307_22

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_21 + var_307_22 and arg_304_1.time_ < var_307_21 + var_307_22 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play1105006075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1105006075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1105006076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.7

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(1105006075).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 28 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 28)

				if (28 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 28)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1105006076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1105006076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1105006077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1.325

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(1105006076).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 53 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 53)

				if (53 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 53)) > 0 and var_317_0 < var_317_3 then
					arg_314_1.talkMaxDuration = var_317_3

					if var_317_3 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_3 + 0
					end
				end

				arg_314_1.text_.text = var_317_1
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_4 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_4

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1105006077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1105006077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1105006078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.525

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(1105006077).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 21 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 21)

				if (21 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 21)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1105006078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1105006078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1105006079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.95

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(1105006078).content)

				arg_322_1.text_.text = var_325_1

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_3 = 38 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 38)

				if (38 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 38)) > 0 and var_325_0 < var_325_3 then
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
	Play1105006079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1105006079
		arg_326_1.duration_ = 9

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1105006080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 4 < arg_326_1.time_ and arg_326_1.time_ <= 4 + arg_329_0 then
				arg_326_1.allBtn_.enabled = false
			end

			if arg_326_1.time_ >= 4 + 0.3 and arg_326_1.time_ < 4 + 0.3 + arg_329_0 then
				arg_326_1.allBtn_.enabled = true
			end

			local var_329_0 = "ST01a"

			if arg_326_1.bgs_.ST01a == nil then
				local var_329_1 = Object.Instantiate(arg_326_1.paintGo_)

				var_329_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_329_0)
				var_329_1.name = var_329_0
				var_329_1.transform.parent = arg_326_1.stage_.transform
				var_329_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.bgs_[var_329_0] = var_329_1
			end

			if 2 < arg_326_1.time_ and arg_326_1.time_ <= 2 + arg_329_0 then
				local var_329_2 = arg_326_1.bgs_.ST01a

				arg_326_1.bgs_.ST01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_329_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_329_3 = var_329_2:GetComponent("SpriteRenderer")

				if var_329_3 and var_329_3.sprite then
					local var_329_4 = 2 * (var_329_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_329_2.transform.localScale = Vector3.New(var_329_4 / var_329_3.sprite.bounds.size.y < var_329_4 * manager.ui.mainCameraCom_.aspect / var_329_3.sprite.bounds.size.x and var_329_4 * manager.ui.mainCameraCom_.aspect / var_329_3.sprite.bounds.size.x or var_329_4 / var_329_3.sprite.bounds.size.y, var_329_4 / var_329_3.sprite.bounds.size.y < var_329_4 * manager.ui.mainCameraCom_.aspect / var_329_3.sprite.bounds.size.x and var_329_4 * manager.ui.mainCameraCom_.aspect / var_329_3.sprite.bounds.size.x or var_329_4 / var_329_3.sprite.bounds.size.y, 0)
				end

				for iter_329_0, iter_329_1 in pairs(arg_326_1.bgs_) do
					if iter_329_0 ~= "ST01a" then
						iter_329_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_329_5 = 0

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_6 = 2

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_6 then
				local var_329_7 = Color.New(0, 0, 0)

				var_329_7.a = Mathf.Lerp(0, 1, (arg_326_1.time_ - var_329_5) / var_329_6)
				arg_326_1.mask_.color = var_329_7
			end

			if arg_326_1.time_ >= var_329_5 + var_329_6 and arg_326_1.time_ < var_329_5 + var_329_6 + arg_329_0 then
				local var_329_8 = Color.New(0, 0, 0)

				var_329_8.a = 1
				arg_326_1.mask_.color = var_329_8
			end

			local var_329_9 = 2

			if 2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_9 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_10 = 2

			if var_329_9 <= arg_326_1.time_ and arg_326_1.time_ < var_329_9 + var_329_10 then
				local var_329_11 = Color.New(0, 0, 0)

				var_329_11.a = Mathf.Lerp(1, 0, (arg_326_1.time_ - var_329_9) / var_329_10)
				arg_326_1.mask_.color = var_329_11
			end

			if arg_326_1.time_ >= var_329_9 + var_329_10 and arg_326_1.time_ < var_329_9 + var_329_10 + arg_329_0 then
				local var_329_12 = Color.New(0, 0, 0)

				arg_326_1.mask_.enabled = false
				var_329_12.a = 0
				arg_326_1.mask_.color = var_329_12
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_13 = 4
			local var_329_14 = 0.75

			if 4 < arg_326_1.time_ and arg_326_1.time_ <= var_329_13 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_15 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_15:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_16 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(1105006079).content)

				arg_326_1.text_.text = var_329_16

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_18 = 30 <= 0 and var_329_14 or var_329_14 * (utf8.len(var_329_16) / 30)

				if (30 <= 0 and var_329_14 or var_329_14 * (utf8.len(var_329_16) / 30)) > 0 and var_329_14 < var_329_18 then
					arg_326_1.talkMaxDuration = var_329_18
					var_329_13 = var_329_13 + 0.3

					if var_329_18 + var_329_13 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_18 + var_329_13
					end
				end

				arg_326_1.text_.text = var_329_16
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_19 = var_329_13 + 0.3
			local var_329_20 = math.max(var_329_14, arg_326_1.talkMaxDuration)

			if var_329_13 + 0.3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_19 + var_329_20 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_19) / var_329_20

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_19 + var_329_20 and arg_326_1.time_ < var_329_19 + var_329_20 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1105006080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1105006080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1105006081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos115001ui_story = arg_332_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["115001ui_story"].transform.position).z)
				arg_332_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["115001ui_story"].transform.localEulerAngles = arg_332_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, -1.033, -6.3)
				arg_332_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["115001ui_story"].transform.position).z)
				arg_332_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["115001ui_story"].transform.localEulerAngles = arg_332_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["115001ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect115001ui_story == nil then
				arg_332_1.var_.characterEffect115001ui_story = var_335_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 and not isNil(var_335_1) then
				if arg_332_1.var_.characterEffect115001ui_story and not isNil(var_335_1) then
					arg_332_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect115001ui_story then
				arg_332_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_335_4 = 0
			local var_335_5 = 0.575

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_6 = arg_332_1:GetWordFromCfg(1105006080)
				local var_335_7 = arg_332_1:FormatText(var_335_6.content)

				arg_332_1.text_.text = var_335_7

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_9 = 23 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 23)

				if (23 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 23)) > 0 and var_335_5 < var_335_9 then
					arg_332_1.talkMaxDuration = var_335_9

					if var_335_9 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_4
					end
				end

				arg_332_1.text_.text = var_335_7
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb") ~= 0 then
					local var_335_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb") / 1000

					if var_335_10 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_4
					end

					if var_335_6.prefab_name ~= "" and arg_332_1.actors_[var_335_6.prefab_name] ~= nil then
						local var_335_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_6.prefab_name].transform, "story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb")

						arg_332_1:RecordAudio("1105006080", var_335_11)
						arg_332_1:RecordAudio("1105006080", var_335_11)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006080", "story_v_side_new_1105006.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_12 = math.max(var_335_5, arg_332_1.talkMaxDuration)

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_12 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_4) / var_335_12

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_4 + var_335_12 and arg_332_1.time_ < var_335_4 + var_335_12 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1105006081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1105006081
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1105006082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["115001ui_story"]) and arg_336_1.var_.characterEffect115001ui_story == nil then
				arg_336_1.var_.characterEffect115001ui_story = arg_336_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["115001ui_story"]) then
				if arg_336_1.var_.characterEffect115001ui_story and not isNil(arg_336_1.actors_["115001ui_story"]) then
					arg_336_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_336_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_0)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["115001ui_story"]) and arg_336_1.var_.characterEffect115001ui_story then
				arg_336_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_336_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_339_1 = 0
			local var_339_2 = 1.1

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(1105006081).content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 44 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 44)

				if (44 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 44)) > 0 and var_339_2 < var_339_5 then
					arg_336_1.talkMaxDuration = var_339_5

					if var_339_5 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + var_339_1
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_6 = math.max(var_339_2, arg_336_1.talkMaxDuration)

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_6 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_1) / var_339_6

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_1 + var_339_6 and arg_336_1.time_ < var_339_1 + var_339_6 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1105006082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1105006082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1105006083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.5

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_1 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(1105006082).content)

				arg_340_1.text_.text = var_343_1

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_3 = 20 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 20)

				if (20 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 20)) > 0 and var_343_0 < var_343_3 then
					arg_340_1.talkMaxDuration = var_343_3

					if var_343_3 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_3 + 0
					end
				end

				arg_340_1.text_.text = var_343_1
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_4 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_4

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1105006083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1105006083
		arg_344_1.duration_ = 2

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1105006084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["115001ui_story"]) and arg_344_1.var_.characterEffect115001ui_story == nil then
				arg_344_1.var_.characterEffect115001ui_story = arg_344_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["115001ui_story"]) then
				if arg_344_1.var_.characterEffect115001ui_story and not isNil(arg_344_1.actors_["115001ui_story"]) then
					arg_344_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["115001ui_story"]) and arg_344_1.var_.characterEffect115001ui_story then
				arg_344_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_2")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_347_2 = 0
			local var_347_3 = 0.15

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_2 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_4 = arg_344_1:GetWordFromCfg(1105006083)
				local var_347_5 = arg_344_1:FormatText(var_347_4.content)

				arg_344_1.text_.text = var_347_5

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_7 = 6 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 6)

				if (6 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 6)) > 0 and var_347_3 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_2
					end
				end

				arg_344_1.text_.text = var_347_5
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb") / 1000

					if var_347_8 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_2
					end

					if var_347_4.prefab_name ~= "" and arg_344_1.actors_[var_347_4.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_4.prefab_name].transform, "story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb")

						arg_344_1:RecordAudio("1105006083", var_347_9)
						arg_344_1:RecordAudio("1105006083", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006083", "story_v_side_new_1105006.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_3, arg_344_1.talkMaxDuration)

			if var_347_2 <= arg_344_1.time_ and arg_344_1.time_ < var_347_2 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_2) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_2 + var_347_10 and arg_344_1.time_ < var_347_2 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1105006084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1105006084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1105006085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["115001ui_story"]) and arg_348_1.var_.characterEffect115001ui_story == nil then
				arg_348_1.var_.characterEffect115001ui_story = arg_348_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_0 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["115001ui_story"]) then
				if arg_348_1.var_.characterEffect115001ui_story and not isNil(arg_348_1.actors_["115001ui_story"]) then
					arg_348_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_348_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 0) / var_351_0)
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["115001ui_story"]) and arg_348_1.var_.characterEffect115001ui_story then
				arg_348_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_348_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_351_1 = 0
			local var_351_2 = 0.85

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(1105006084).content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 34 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 34)

				if (34 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 34)) > 0 and var_351_2 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_1
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_6 = math.max(var_351_2, arg_348_1.talkMaxDuration)

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_6 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_1) / var_351_6

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_1 + var_351_6 and arg_348_1.time_ < var_351_1 + var_351_6 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1105006085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1105006085
		arg_352_1.duration_ = 3.67

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1105006086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["115001ui_story"]) and arg_352_1.var_.characterEffect115001ui_story == nil then
				arg_352_1.var_.characterEffect115001ui_story = arg_352_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["115001ui_story"]) then
				if arg_352_1.var_.characterEffect115001ui_story and not isNil(arg_352_1.actors_["115001ui_story"]) then
					arg_352_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["115001ui_story"]) and arg_352_1.var_.characterEffect115001ui_story then
				arg_352_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_355_2 = 0
			local var_355_3 = 0.375

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_2 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_4 = arg_352_1:GetWordFromCfg(1105006085)
				local var_355_5 = arg_352_1:FormatText(var_355_4.content)

				arg_352_1.text_.text = var_355_5

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_7 = 15 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 15)

				if (15 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 15)) > 0 and var_355_3 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_2
					end
				end

				arg_352_1.text_.text = var_355_5
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb") / 1000

					if var_355_8 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_2
					end

					if var_355_4.prefab_name ~= "" and arg_352_1.actors_[var_355_4.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_4.prefab_name].transform, "story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb")

						arg_352_1:RecordAudio("1105006085", var_355_9)
						arg_352_1:RecordAudio("1105006085", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006085", "story_v_side_new_1105006.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_3, arg_352_1.talkMaxDuration)

			if var_355_2 <= arg_352_1.time_ and arg_352_1.time_ < var_355_2 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_2) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_2 + var_355_10 and arg_352_1.time_ < var_355_2 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1105006086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1105006086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1105006087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["115001ui_story"]) and arg_356_1.var_.characterEffect115001ui_story == nil then
				arg_356_1.var_.characterEffect115001ui_story = arg_356_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["115001ui_story"]) then
				if arg_356_1.var_.characterEffect115001ui_story and not isNil(arg_356_1.actors_["115001ui_story"]) then
					arg_356_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_356_1.var_.characterEffect115001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_356_1.time_ - 0) / var_359_0)
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["115001ui_story"]) and arg_356_1.var_.characterEffect115001ui_story then
				arg_356_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_356_1.var_.characterEffect115001ui_story.fillRatio = 0.5
			end

			local var_359_1 = 0
			local var_359_2 = 0.525

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(1105006086).content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 21 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 21)

				if (21 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 21)) > 0 and var_359_2 < var_359_5 then
					arg_356_1.talkMaxDuration = var_359_5

					if var_359_5 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_6 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_6 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_6

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_6 and arg_356_1.time_ < var_359_1 + var_359_6 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1105006087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1105006087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1105006088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos115001ui_story = arg_360_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_363_0 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 then
				arg_360_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_360_1.time_ - 0) / var_363_0)
				arg_360_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["115001ui_story"].transform.position).z)
				arg_360_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["115001ui_story"].transform.localEulerAngles = arg_360_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 then
				arg_360_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_360_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["115001ui_story"].transform.position).z)
				arg_360_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["115001ui_story"].transform.localEulerAngles = arg_360_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_363_1 = 0
			local var_363_2 = 0.825

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(1105006087).content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 33 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 33)

				if (33 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 33)) > 0 and var_363_2 < var_363_5 then
					arg_360_1.talkMaxDuration = var_363_5

					if var_363_5 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_6 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_6 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_6

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_6 and arg_360_1.time_ < var_363_1 + var_363_6 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play1105006088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1105006088
		arg_364_1.duration_ = 6.83

		local var_364_0 = {
			zh = 5.333,
			CriLanguages = 6.833
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1105006089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.35

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:GetWordFromCfg(1105006088)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 14 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 14)

				if (14 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 14)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb")

						arg_364_1:RecordAudio("1105006088", var_367_6)
						arg_364_1:RecordAudio("1105006088", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006088", "story_v_side_new_1105006.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1105006089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1105006089
		arg_368_1.duration_ = 2

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1105006090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["115001ui_story"]) and arg_368_1.var_.characterEffect115001ui_story == nil then
				arg_368_1.var_.characterEffect115001ui_story = arg_368_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_0 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["115001ui_story"]) then
				if arg_368_1.var_.characterEffect115001ui_story and not isNil(arg_368_1.actors_["115001ui_story"]) then
					arg_368_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["115001ui_story"]) and arg_368_1.var_.characterEffect115001ui_story then
				arg_368_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_2 = arg_368_1.actors_["115001ui_story"].transform

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos115001ui_story = var_371_2.localPosition
			end

			local var_371_3 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_3 then
				var_371_2.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_368_1.time_ - 0) / var_371_3)
				var_371_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_2.position).x, (manager.ui.mainCamera.transform.position - var_371_2.position).y, (manager.ui.mainCamera.transform.position - var_371_2.position).z)
				var_371_2.localEulerAngles.z = 0
				var_371_2.localEulerAngles.x = 0
				var_371_2.localEulerAngles = var_371_2.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_3 and arg_368_1.time_ < 0 + var_371_3 + arg_371_0 then
				var_371_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_371_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_2.position).x, (manager.ui.mainCamera.transform.position - var_371_2.position).y, (manager.ui.mainCamera.transform.position - var_371_2.position).z)
				var_371_2.localEulerAngles.z = 0
				var_371_2.localEulerAngles.x = 0
				var_371_2.localEulerAngles = var_371_2.localEulerAngles
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			local var_371_4 = 0
			local var_371_5 = 0.075

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_6 = arg_368_1:GetWordFromCfg(1105006089)
				local var_371_7 = arg_368_1:FormatText(var_371_6.content)

				arg_368_1.text_.text = var_371_7

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 3 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 3)

				if (3 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 3)) > 0 and var_371_5 < var_371_9 then
					arg_368_1.talkMaxDuration = var_371_9

					if var_371_9 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_7
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb") ~= 0 then
					local var_371_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb") / 1000

					if var_371_10 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_4
					end

					if var_371_6.prefab_name ~= "" and arg_368_1.actors_[var_371_6.prefab_name] ~= nil then
						local var_371_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_6.prefab_name].transform, "story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb")

						arg_368_1:RecordAudio("1105006089", var_371_11)
						arg_368_1:RecordAudio("1105006089", var_371_11)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006089", "story_v_side_new_1105006.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_12 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_12 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_12

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_12 and arg_368_1.time_ < var_371_4 + var_371_12 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play1105006090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1105006090
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1105006091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos115001ui_story = arg_372_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["115001ui_story"].transform.position).z)
				arg_372_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["115001ui_story"].transform.localEulerAngles = arg_372_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_372_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["115001ui_story"].transform.position).z)
				arg_372_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["115001ui_story"].transform.localEulerAngles = arg_372_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if 1.9 < arg_372_1.time_ and arg_372_1.time_ <= 1.9 + arg_375_0 then
				arg_372_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_handtouch1", "")
			end

			local var_375_2 = 0
			local var_375_3 = 1.025

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_4 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(1105006090).content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 41 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_4) / 41)

				if (41 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_4) / 41)) > 0 and var_375_3 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_2
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_3, arg_372_1.talkMaxDuration)

			if var_375_2 <= arg_372_1.time_ and arg_372_1.time_ < var_375_2 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_2) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_2 + var_375_7 and arg_372_1.time_ < var_375_2 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play1105006091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1105006091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1105006092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.475

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_1 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(1105006091).content)

				arg_376_1.text_.text = var_379_1

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_3 = 19 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 19)

				if (19 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 19)) > 0 and var_379_0 < var_379_3 then
					arg_376_1.talkMaxDuration = var_379_3

					if var_379_3 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_3 + 0
					end
				end

				arg_376_1.text_.text = var_379_1
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_4 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_4 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_4

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_4 and arg_376_1.time_ < 0 + var_379_4 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1105006092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1105006092
		arg_380_1.duration_ = 2

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1105006093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["115001ui_story"]) and arg_380_1.var_.characterEffect115001ui_story == nil then
				arg_380_1.var_.characterEffect115001ui_story = arg_380_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["115001ui_story"]) then
				if arg_380_1.var_.characterEffect115001ui_story and not isNil(arg_380_1.actors_["115001ui_story"]) then
					arg_380_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["115001ui_story"]) and arg_380_1.var_.characterEffect115001ui_story then
				arg_380_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_383_2 = arg_380_1.actors_["115001ui_story"].transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos115001ui_story = var_383_2.localPosition
			end

			local var_383_3 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_3 then
				var_383_2.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_380_1.time_ - 0) / var_383_3)
				var_383_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_2.position).x, (manager.ui.mainCamera.transform.position - var_383_2.position).y, (manager.ui.mainCamera.transform.position - var_383_2.position).z)
				var_383_2.localEulerAngles.z = 0
				var_383_2.localEulerAngles.x = 0
				var_383_2.localEulerAngles = var_383_2.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_3 and arg_380_1.time_ < 0 + var_383_3 + arg_383_0 then
				var_383_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_383_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_2.position).x, (manager.ui.mainCamera.transform.position - var_383_2.position).y, (manager.ui.mainCamera.transform.position - var_383_2.position).z)
				var_383_2.localEulerAngles.z = 0
				var_383_2.localEulerAngles.x = 0
				var_383_2.localEulerAngles = var_383_2.localEulerAngles
			end

			local var_383_4 = 0
			local var_383_5 = 0.275

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_6 = arg_380_1:GetWordFromCfg(1105006092)
				local var_383_7 = arg_380_1:FormatText(var_383_6.content)

				arg_380_1.text_.text = var_383_7

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_9 = 11 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 11)

				if (11 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 11)) > 0 and var_383_5 < var_383_9 then
					arg_380_1.talkMaxDuration = var_383_9

					if var_383_9 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_9 + var_383_4
					end
				end

				arg_380_1.text_.text = var_383_7
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb") ~= 0 then
					local var_383_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb") / 1000

					if var_383_10 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_10 + var_383_4
					end

					if var_383_6.prefab_name ~= "" and arg_380_1.actors_[var_383_6.prefab_name] ~= nil then
						local var_383_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_6.prefab_name].transform, "story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb")

						arg_380_1:RecordAudio("1105006092", var_383_11)
						arg_380_1:RecordAudio("1105006092", var_383_11)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006092", "story_v_side_new_1105006.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_12 = math.max(var_383_5, arg_380_1.talkMaxDuration)

			if var_383_4 <= arg_380_1.time_ and arg_380_1.time_ < var_383_4 + var_383_12 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_4) / var_383_12

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_4 + var_383_12 and arg_380_1.time_ < var_383_4 + var_383_12 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play1105006093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1105006093
		arg_384_1.duration_ = 7.7

		local var_384_0 = {
			zh = 7.7,
			CriLanguages = 6.633
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1105006094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos115001ui_story = arg_384_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["115001ui_story"].transform.position).z)
				arg_384_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["115001ui_story"].transform.localEulerAngles = arg_384_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_384_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["115001ui_story"].transform.position).z)
				arg_384_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["115001ui_story"].transform.localEulerAngles = arg_384_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_387_1 = 0
			local var_387_2 = 0.35

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(1105006093)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_6 = 14 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_4) / 14)

				if (14 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_4) / 14)) > 0 and var_387_2 < var_387_6 then
					arg_384_1.talkMaxDuration = var_387_6

					if var_387_6 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_6 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb") ~= 0 then
					local var_387_7 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb") / 1000

					if var_387_7 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_1
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb")

						arg_384_1:RecordAudio("1105006093", var_387_8)
						arg_384_1:RecordAudio("1105006093", var_387_8)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006093", "story_v_side_new_1105006.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_9 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_9 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_9

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_9 and arg_384_1.time_ < var_387_1 + var_387_9 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play1105006094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1105006094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1105006095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 1.5 < arg_388_1.time_ and arg_388_1.time_ <= 1.5 + arg_391_0 then
				arg_388_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_handtouch2", "")
			end

			local var_391_1 = 0
			local var_391_2 = 1.75

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_3 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(1105006094).content)

				arg_388_1.text_.text = var_391_3

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 70 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 70)

				if (70 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 70)) > 0 and var_391_2 < var_391_5 then
					arg_388_1.talkMaxDuration = var_391_5

					if var_391_5 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + var_391_1
					end
				end

				arg_388_1.text_.text = var_391_3
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_6 = math.max(var_391_2, arg_388_1.talkMaxDuration)

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_6 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_1) / var_391_6

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_1 + var_391_6 and arg_388_1.time_ < var_391_1 + var_391_6 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1105006095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1105006095
		arg_392_1.duration_ = 2

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1105006096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos115001ui_story = arg_392_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_395_0 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 then
				arg_392_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_392_1.time_ - 0) / var_395_0)
				arg_392_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["115001ui_story"].transform.position).z)
				arg_392_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["115001ui_story"].transform.localEulerAngles = arg_392_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 then
				arg_392_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, -1.033, -6.3)
				arg_392_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["115001ui_story"].transform.position).z)
				arg_392_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["115001ui_story"].transform.localEulerAngles = arg_392_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_395_1 = arg_392_1.actors_["115001ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_1) and arg_392_1.var_.characterEffect115001ui_story == nil then
				arg_392_1.var_.characterEffect115001ui_story = var_395_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_2 and not isNil(var_395_1) then
				if arg_392_1.var_.characterEffect115001ui_story and not isNil(var_395_1) then
					arg_392_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_2 and arg_392_1.time_ < 0 + var_395_2 + arg_395_0 and not isNil(var_395_1) and arg_392_1.var_.characterEffect115001ui_story then
				arg_392_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_395_4 = 0
			local var_395_5 = 0.1

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_6 = arg_392_1:GetWordFromCfg(1105006095)
				local var_395_7 = arg_392_1:FormatText(var_395_6.content)

				arg_392_1.text_.text = var_395_7

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_9 = 4 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_7) / 4)

				if (4 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_7) / 4)) > 0 and var_395_5 < var_395_9 then
					arg_392_1.talkMaxDuration = var_395_9

					if var_395_9 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_9 + var_395_4
					end
				end

				arg_392_1.text_.text = var_395_7
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb") ~= 0 then
					local var_395_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb") / 1000

					if var_395_10 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_10 + var_395_4
					end

					if var_395_6.prefab_name ~= "" and arg_392_1.actors_[var_395_6.prefab_name] ~= nil then
						local var_395_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_6.prefab_name].transform, "story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb")

						arg_392_1:RecordAudio("1105006095", var_395_11)
						arg_392_1:RecordAudio("1105006095", var_395_11)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006095", "story_v_side_new_1105006.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_12 = math.max(var_395_5, arg_392_1.talkMaxDuration)

			if var_395_4 <= arg_392_1.time_ and arg_392_1.time_ < var_395_4 + var_395_12 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_4) / var_395_12

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_4 + var_395_12 and arg_392_1.time_ < var_395_4 + var_395_12 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play1105006096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1105006096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1105006097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos115001ui_story = arg_396_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_399_0 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 then
				arg_396_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_0)
				arg_396_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["115001ui_story"].transform.position).z)
				arg_396_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["115001ui_story"].transform.localEulerAngles = arg_396_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 then
				arg_396_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_396_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["115001ui_story"].transform.position).z)
				arg_396_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["115001ui_story"].transform.localEulerAngles = arg_396_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_399_1 = 0
			local var_399_2 = 0.55

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(1105006096).content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 22 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 22)

				if (22 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 22)) > 0 and var_399_2 < var_399_5 then
					arg_396_1.talkMaxDuration = var_399_5

					if var_399_5 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_6 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_6 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_6

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_6 and arg_396_1.time_ < var_399_1 + var_399_6 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play1105006097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1105006097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1105006098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 1.175

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_1 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(1105006097).content)

				arg_400_1.text_.text = var_403_1

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_3 = 47 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 47)

				if (47 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 47)) > 0 and var_403_0 < var_403_3 then
					arg_400_1.talkMaxDuration = var_403_3

					if var_403_3 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_3 + 0
					end
				end

				arg_400_1.text_.text = var_403_1
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_4 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_4

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1105006098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1105006098
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1105006099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.55

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_1 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(1105006098).content)

				arg_404_1.text_.text = var_407_1

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_3 = 22 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_1) / 22)

				if (22 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_1) / 22)) > 0 and var_407_0 < var_407_3 then
					arg_404_1.talkMaxDuration = var_407_3

					if var_407_3 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_3 + 0
					end
				end

				arg_404_1.text_.text = var_407_1
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_4 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_4 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_4

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_4 and arg_404_1.time_ < 0 + var_407_4 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1105006099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1105006099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1105006100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 1.2

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(1105006099).content)

				arg_408_1.text_.text = var_411_1

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_3 = 48 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 48)

				if (48 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 48)) > 0 and var_411_0 < var_411_3 then
					arg_408_1.talkMaxDuration = var_411_3

					if var_411_3 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_3 + 0
					end
				end

				arg_408_1.text_.text = var_411_1
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_4 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_4

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1105006100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1105006100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1105006101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.35

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_1 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(1105006100).content)

				arg_412_1.text_.text = var_415_1

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_3 = 14 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 14)

				if (14 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 14)) > 0 and var_415_0 < var_415_3 then
					arg_412_1.talkMaxDuration = var_415_3

					if var_415_3 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_3 + 0
					end
				end

				arg_412_1.text_.text = var_415_1
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_4 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_4

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1105006101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1105006101
		arg_416_1.duration_ = 7.6

		local var_416_0 = {
			zh = 6.766,
			CriLanguages = 7.6
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1105006102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.35

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:GetWordFromCfg(1105006101)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 14 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 14)

				if (14 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 14)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb")

						arg_416_1:RecordAudio("1105006101", var_419_6)
						arg_416_1:RecordAudio("1105006101", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006101", "story_v_side_new_1105006.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1105006102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1105006102
		arg_420_1.duration_ = 2

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1105006103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_423_0 = arg_420_1.actors_["115001ui_story"].transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos115001ui_story = var_423_0.localPosition
			end

			local var_423_1 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_1 then
				var_423_0.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_420_1.time_ - 0) / var_423_1)
				var_423_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_0.position).x, (manager.ui.mainCamera.transform.position - var_423_0.position).y, (manager.ui.mainCamera.transform.position - var_423_0.position).z)
				var_423_0.localEulerAngles.z = 0
				var_423_0.localEulerAngles.x = 0
				var_423_0.localEulerAngles = var_423_0.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_1 and arg_420_1.time_ < 0 + var_423_1 + arg_423_0 then
				var_423_0.localPosition = Vector3.New(0, -1.033, -6.3)
				var_423_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_0.position).x, (manager.ui.mainCamera.transform.position - var_423_0.position).y, (manager.ui.mainCamera.transform.position - var_423_0.position).z)
				var_423_0.localEulerAngles.z = 0
				var_423_0.localEulerAngles.x = 0
				var_423_0.localEulerAngles = var_423_0.localEulerAngles
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_423_2 = arg_420_1.actors_["115001ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.characterEffect115001ui_story == nil then
				arg_420_1.var_.characterEffect115001ui_story = var_423_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_3 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_3 and not isNil(var_423_2) then
				if arg_420_1.var_.characterEffect115001ui_story and not isNil(var_423_2) then
					arg_420_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_3 and arg_420_1.time_ < 0 + var_423_3 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.characterEffect115001ui_story then
				arg_420_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_423_5 = 0
			local var_423_6 = 0.125

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[374].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_7 = arg_420_1:GetWordFromCfg(1105006102)
				local var_423_8 = arg_420_1:FormatText(var_423_7.content)

				arg_420_1.text_.text = var_423_8

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_10 = 5 <= 0 and var_423_6 or var_423_6 * (utf8.len(var_423_8) / 5)

				if (5 <= 0 and var_423_6 or var_423_6 * (utf8.len(var_423_8) / 5)) > 0 and var_423_6 < var_423_10 then
					arg_420_1.talkMaxDuration = var_423_10

					if var_423_10 + var_423_5 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_10 + var_423_5
					end
				end

				arg_420_1.text_.text = var_423_8
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb") ~= 0 then
					local var_423_11 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb") / 1000

					if var_423_11 + var_423_5 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_11 + var_423_5
					end

					if var_423_7.prefab_name ~= "" and arg_420_1.actors_[var_423_7.prefab_name] ~= nil then
						local var_423_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_7.prefab_name].transform, "story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb")

						arg_420_1:RecordAudio("1105006102", var_423_12)
						arg_420_1:RecordAudio("1105006102", var_423_12)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006102", "story_v_side_new_1105006.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_13 = math.max(var_423_6, arg_420_1.talkMaxDuration)

			if var_423_5 <= arg_420_1.time_ and arg_420_1.time_ < var_423_5 + var_423_13 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_5) / var_423_13

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_5 + var_423_13 and arg_420_1.time_ < var_423_5 + var_423_13 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play1105006103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1105006103
		arg_424_1.duration_ = 6

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1105006104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_427_0 = 0.833333333333333

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				local var_427_1, var_427_2 = math.modf((arg_424_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_427_2 * 0.13, var_427_2 * 0.13, var_427_2 * 0.13) + arg_424_1.var_.shakeOldPos
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				manager.ui.mainCamera.transform.localPosition = arg_424_1.var_.shakeOldPos
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_427_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_424_1.bgmTxt_.text ~= var_427_5 and arg_424_1.bgmTxt_.text ~= "" then
						if arg_424_1.bgmTxt2_.text ~= "" then
							arg_424_1.bgmTxt_.text = arg_424_1.bgmTxt2_.text
						end

						arg_424_1.bgmTxt2_.text = var_427_5

						arg_424_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_424_1.bgmTxt_.text = var_427_5
						arg_424_1.bgmTxt2_.text = var_427_5
					end

					if arg_424_1.bgmTimer then
						arg_424_1.bgmTimer:Stop()

						arg_424_1.bgmTimer = nil
					end

					if arg_424_1.settingData.show_music_name == 1 then
						arg_424_1.musicController:SetSelectedState("show")
						arg_424_1.musicAnimator_:Play("open", 0, 0)

						if arg_424_1.settingData.music_time ~= 0 then
							arg_424_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_424_1.settingData.music_time), function()
								if arg_424_1 == nil or isNil(arg_424_1.bgmTxt_) then
									return
								end

								arg_424_1.musicController:SetSelectedState("hide")
								arg_424_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_427_6 = 0

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.allBtn_.enabled = false
			end

			if arg_424_1.time_ >= var_427_6 + 1 and arg_424_1.time_ < var_427_6 + 1 + arg_427_0 then
				arg_424_1.allBtn_.enabled = true
			end

			local var_427_7 = arg_424_1.actors_["115001ui_story"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos115001ui_story = var_427_7.localPosition
			end

			local var_427_8 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_8 then
				var_427_7.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_424_1.time_ - 0) / var_427_8)
				var_427_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_7.position).x, (manager.ui.mainCamera.transform.position - var_427_7.position).y, (manager.ui.mainCamera.transform.position - var_427_7.position).z)
				var_427_7.localEulerAngles.z = 0
				var_427_7.localEulerAngles.x = 0
				var_427_7.localEulerAngles = var_427_7.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_8 and arg_424_1.time_ < 0 + var_427_8 + arg_427_0 then
				var_427_7.localPosition = Vector3.New(0, 100, 0)
				var_427_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_7.position).x, (manager.ui.mainCamera.transform.position - var_427_7.position).y, (manager.ui.mainCamera.transform.position - var_427_7.position).z)
				var_427_7.localEulerAngles.z = 0
				var_427_7.localEulerAngles.x = 0
				var_427_7.localEulerAngles = var_427_7.localEulerAngles
			end

			if arg_424_1.frameCnt_ <= 1 then
				arg_424_1.dialog_:SetActive(false)
			end

			local var_427_9 = 1
			local var_427_10 = 0.775

			if 1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_9 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0

				arg_424_1.dialog_:SetActive(true)

				arg_424_1.dialogCg_.alpha = 0

				local var_427_11 = LeanTween.value(arg_424_1.dialog_, 0, 1, 0.3)

				var_427_11:setOnUpdate(LuaHelper.FloatAction(function(arg_429_0)
					arg_424_1.dialogCg_.alpha = arg_429_0
				end))
				var_427_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_424_1.dialog_)
					var_427_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_424_1.duration_ = arg_424_1.duration_ + 0.3

				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_12 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(1105006103).content)

				arg_424_1.text_.text = var_427_12

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_14 = 31 <= 0 and var_427_10 or var_427_10 * (utf8.len(var_427_12) / 31)

				if (31 <= 0 and var_427_10 or var_427_10 * (utf8.len(var_427_12) / 31)) > 0 and var_427_10 < var_427_14 then
					arg_424_1.talkMaxDuration = var_427_14
					var_427_9 = var_427_9 + 0.3

					if var_427_14 + var_427_9 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_9
					end
				end

				arg_424_1.text_.text = var_427_12
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_15 = var_427_9 + 0.3
			local var_427_16 = math.max(var_427_10, arg_424_1.talkMaxDuration)

			if var_427_9 + 0.3 <= arg_424_1.time_ and arg_424_1.time_ < var_427_15 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_15) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_15 + var_427_16 and arg_424_1.time_ < var_427_15 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play1105006104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1105006104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1105006105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.15

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1105006104).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 46 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 46)

				if (46 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 46)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1105006105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1105006105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1105006106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 1.225

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(1105006105).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 49 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 49)

				if (49 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 49)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1105006106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1105006106
		arg_439_1.duration_ = 6

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1105006107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if arg_439_1.bgs_.ST01a_blur == nil then
				local var_442_0 = Object.Instantiate(arg_439_1.blurPaintGo_)

				var_442_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01a_blur")
				var_442_0.name = "ST01a_blur"
				var_442_0.transform.parent = arg_439_1.stage_.transform
				var_442_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_439_1.bgs_.ST01a_blur = var_442_0
			end

			local var_442_1 = 0
			local var_442_2 = arg_439_1.bgs_.ST01a_blur

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				var_442_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_442_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_442_3 = var_442_2:GetComponent("SpriteRenderer")

				if var_442_3 and var_442_3.sprite then
					local var_442_4 = 2 * (var_442_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_442_2.transform.localScale = Vector3.New(var_442_4 / var_442_3.sprite.bounds.size.y < var_442_4 * manager.ui.mainCameraCom_.aspect / var_442_3.sprite.bounds.size.x and var_442_4 * manager.ui.mainCameraCom_.aspect / var_442_3.sprite.bounds.size.x or var_442_4 / var_442_3.sprite.bounds.size.y, var_442_4 / var_442_3.sprite.bounds.size.y < var_442_4 * manager.ui.mainCameraCom_.aspect / var_442_3.sprite.bounds.size.x and var_442_4 * manager.ui.mainCameraCom_.aspect / var_442_3.sprite.bounds.size.x or var_442_4 / var_442_3.sprite.bounds.size.y, 0)
				end
			end

			local var_442_5 = 1

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_5 then
				local var_442_6 = Color.New(1, 1, 1)

				var_442_6.a = Mathf.Lerp(0, 1, (arg_439_1.time_ - var_442_1) / var_442_5)

				var_442_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_442_6)
			end

			local var_442_7 = 0

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_7 + arg_442_0 then
				arg_439_1.allBtn_.enabled = false
			end

			if arg_439_1.time_ >= var_442_7 + 1 and arg_439_1.time_ < var_442_7 + 1 + arg_442_0 then
				arg_439_1.allBtn_.enabled = true
			end

			if arg_439_1.frameCnt_ <= 1 then
				arg_439_1.dialog_:SetActive(false)
			end

			local var_442_8 = 1
			local var_442_9 = 0.525

			if 1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_8 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				arg_439_1.dialog_:SetActive(true)

				arg_439_1.dialogCg_.alpha = 0

				local var_442_10 = LeanTween.value(arg_439_1.dialog_, 0, 1, 0.3)

				var_442_10:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_439_1.dialogCg_.alpha = arg_443_0
				end))
				var_442_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_439_1.dialog_)
					var_442_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_439_1.duration_ = arg_439_1.duration_ + 0.3

				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_11 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1105006106).content)

				arg_439_1.text_.text = var_442_11

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_13 = 21 <= 0 and var_442_9 or var_442_9 * (utf8.len(var_442_11) / 21)

				if (21 <= 0 and var_442_9 or var_442_9 * (utf8.len(var_442_11) / 21)) > 0 and var_442_9 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13
					var_442_8 = var_442_8 + 0.3

					if var_442_13 + var_442_8 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_8
					end
				end

				arg_439_1.text_.text = var_442_11
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_14 = var_442_8 + 0.3
			local var_442_15 = math.max(var_442_9, arg_439_1.talkMaxDuration)

			if var_442_8 + 0.3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_14 + var_442_15 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_14) / var_442_15

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_14 + var_442_15 and arg_439_1.time_ < var_442_14 + var_442_15 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1105006107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1105006107
		arg_445_1.duration_ = 5.57

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1105006108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = false

				arg_445_1:SetGaussion(false)
			end

			local var_448_0 = 0.366666666666667

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				local var_448_1 = Color.New(1, 1, 1)

				var_448_1.a = Mathf.Lerp(1, 0, (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.mask_.color = var_448_1
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				local var_448_2 = Color.New(1, 1, 1)

				arg_445_1.mask_.enabled = false
				var_448_2.a = 0
				arg_445_1.mask_.color = var_448_2
			end

			local var_448_3 = manager.ui.mainCamera.transform

			if 0.233333333333333 < arg_445_1.time_ and arg_445_1.time_ <= 0.233333333333333 + arg_448_0 then
				arg_445_1.var_.shakeOldPos = var_448_3.localPosition
			end

			local var_448_4 = 0.333333333333333

			if 0.233333333333333 <= arg_445_1.time_ and arg_445_1.time_ < 0.233333333333333 + var_448_4 then
				local var_448_5, var_448_6 = math.modf((arg_445_1.time_ - 0.233333333333333) / 0.066)

				var_448_3.localPosition = Vector3.New(var_448_6 * 0.13, var_448_6 * 0.13, var_448_6 * 0.13) + arg_445_1.var_.shakeOldPos
			end

			if arg_445_1.time_ >= 0.233333333333333 + var_448_4 and arg_445_1.time_ < 0.233333333333333 + var_448_4 + arg_448_0 then
				var_448_3.localPosition = arg_445_1.var_.shakeOldPos
			end

			local var_448_7 = 0

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_7 + arg_448_0 then
				arg_445_1.allBtn_.enabled = false
			end

			if arg_445_1.time_ >= var_448_7 + 0.566666666666667 and arg_445_1.time_ < var_448_7 + 0.566666666666667 + arg_448_0 then
				arg_445_1.allBtn_.enabled = true
			end

			if arg_445_1.frameCnt_ <= 1 then
				arg_445_1.dialog_:SetActive(false)
			end

			local var_448_8 = 0.566666666666667
			local var_448_9 = 0.075

			if 0.566666666666667 < arg_445_1.time_ and arg_445_1.time_ <= var_448_8 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0

				arg_445_1.dialog_:SetActive(true)

				arg_445_1.dialogCg_.alpha = 0

				local var_448_10 = LeanTween.value(arg_445_1.dialog_, 0, 1, 0.3)

				var_448_10:setOnUpdate(LuaHelper.FloatAction(function(arg_449_0)
					arg_445_1.dialogCg_.alpha = arg_449_0
				end))
				var_448_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_445_1.dialog_)
					var_448_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_445_1.duration_ = arg_445_1.duration_ + 0.3

				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_11 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1105006107).content)

				arg_445_1.text_.text = var_448_11

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_13 = 3 <= 0 and var_448_9 or var_448_9 * (utf8.len(var_448_11) / 3)

				if (3 <= 0 and var_448_9 or var_448_9 * (utf8.len(var_448_11) / 3)) > 0 and var_448_9 < var_448_13 then
					arg_445_1.talkMaxDuration = var_448_13
					var_448_8 = var_448_8 + 0.3

					if var_448_13 + var_448_8 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_13 + var_448_8
					end
				end

				arg_445_1.text_.text = var_448_11
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_14 = var_448_8 + 0.3
			local var_448_15 = math.max(var_448_9, arg_445_1.talkMaxDuration)

			if var_448_8 + 0.3 <= arg_445_1.time_ and arg_445_1.time_ < var_448_14 + var_448_15 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_14) / var_448_15

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_14 + var_448_15 and arg_445_1.time_ < var_448_14 + var_448_15 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1105006108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1105006108
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1105006109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 1.375

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(1105006108).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 55 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 55)

				if (55 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 55)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1105006109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1105006109
		arg_455_1.duration_ = 2.27

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1105006110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["115001ui_story"]) and arg_455_1.var_.characterEffect115001ui_story == nil then
				arg_455_1.var_.characterEffect115001ui_story = arg_455_1.actors_["115001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["115001ui_story"]) then
				if arg_455_1.var_.characterEffect115001ui_story and not isNil(arg_455_1.actors_["115001ui_story"]) then
					arg_455_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["115001ui_story"]) and arg_455_1.var_.characterEffect115001ui_story then
				arg_455_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_458_2 = arg_455_1.actors_["115001ui_story"].transform

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos115001ui_story = var_458_2.localPosition
			end

			local var_458_3 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_3 then
				var_458_2.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos115001ui_story, Vector3.New(0, -1.033, -6.3), (arg_455_1.time_ - 0) / var_458_3)
				var_458_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_458_2.position).x, (manager.ui.mainCamera.transform.position - var_458_2.position).y, (manager.ui.mainCamera.transform.position - var_458_2.position).z)
				var_458_2.localEulerAngles.z = 0
				var_458_2.localEulerAngles.x = 0
				var_458_2.localEulerAngles = var_458_2.localEulerAngles
			end

			if arg_455_1.time_ >= 0 + var_458_3 and arg_455_1.time_ < 0 + var_458_3 + arg_458_0 then
				var_458_2.localPosition = Vector3.New(0, -1.033, -6.3)
				var_458_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_458_2.position).x, (manager.ui.mainCamera.transform.position - var_458_2.position).y, (manager.ui.mainCamera.transform.position - var_458_2.position).z)
				var_458_2.localEulerAngles.z = 0
				var_458_2.localEulerAngles.x = 0
				var_458_2.localEulerAngles = var_458_2.localEulerAngles
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_458_4 = 0
			local var_458_5 = 0.25

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_6 = arg_455_1:GetWordFromCfg(1105006109)
				local var_458_7 = arg_455_1:FormatText(var_458_6.content)

				arg_455_1.text_.text = var_458_7

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_9 = 10 <= 0 and var_458_5 or var_458_5 * (utf8.len(var_458_7) / 10)

				if (10 <= 0 and var_458_5 or var_458_5 * (utf8.len(var_458_7) / 10)) > 0 and var_458_5 < var_458_9 then
					arg_455_1.talkMaxDuration = var_458_9

					if var_458_9 + var_458_4 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_4
					end
				end

				arg_455_1.text_.text = var_458_7
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb") ~= 0 then
					local var_458_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb") / 1000

					if var_458_10 + var_458_4 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_10 + var_458_4
					end

					if var_458_6.prefab_name ~= "" and arg_455_1.actors_[var_458_6.prefab_name] ~= nil then
						local var_458_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_6.prefab_name].transform, "story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb")

						arg_455_1:RecordAudio("1105006109", var_458_11)
						arg_455_1:RecordAudio("1105006109", var_458_11)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006109", "story_v_side_new_1105006.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_12 = math.max(var_458_5, arg_455_1.talkMaxDuration)

			if var_458_4 <= arg_455_1.time_ and arg_455_1.time_ < var_458_4 + var_458_12 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_4) / var_458_12

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_4 + var_458_12 and arg_455_1.time_ < var_458_4 + var_458_12 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play1105006110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1105006110
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1105006111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos115001ui_story = arg_459_1.actors_["115001ui_story"].transform.localPosition
			end

			local var_462_0 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 then
				arg_459_1.actors_["115001ui_story"].transform.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos115001ui_story, Vector3.New(0, 100, 0), (arg_459_1.time_ - 0) / var_462_0)
				arg_459_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["115001ui_story"].transform.position).z)
				arg_459_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["115001ui_story"].transform.localEulerAngles = arg_459_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 then
				arg_459_1.actors_["115001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_459_1.actors_["115001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["115001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["115001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["115001ui_story"].transform.position).z)
				arg_459_1.actors_["115001ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["115001ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["115001ui_story"].transform.localEulerAngles = arg_459_1.actors_["115001ui_story"].transform.localEulerAngles
			end

			local var_462_1 = 0
			local var_462_2 = 0.35

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1105006110).content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 14 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 14)

				if (14 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 14)) > 0 and var_462_2 < var_462_5 then
					arg_459_1.talkMaxDuration = var_462_5

					if var_462_5 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + var_462_1
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_6 = math.max(var_462_2, arg_459_1.talkMaxDuration)

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_6 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_1) / var_462_6

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_1 + var_462_6 and arg_459_1.time_ < var_462_1 + var_462_6 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play1105006111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1105006111
		arg_463_1.duration_ = 7

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1105006112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 2 < arg_463_1.time_ and arg_463_1.time_ <= 2 + arg_466_0 then
				arg_463_1.allBtn_.enabled = false
			end

			if arg_463_1.time_ >= 2 + 0.3 and arg_463_1.time_ < 2 + 0.3 + arg_466_0 then
				arg_463_1.allBtn_.enabled = true
			end

			local var_466_0 = "R5002"

			if arg_463_1.bgs_.R5002 == nil then
				local var_466_1 = Object.Instantiate(arg_463_1.paintGo_)

				var_466_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_466_0)
				var_466_1.name = var_466_0
				var_466_1.transform.parent = arg_463_1.stage_.transform
				var_466_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_463_1.bgs_[var_466_0] = var_466_1
			end

			if 1 < arg_463_1.time_ and arg_463_1.time_ <= 1 + arg_466_0 then
				local var_466_2 = arg_463_1.bgs_.R5002

				arg_463_1.bgs_.R5002.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_466_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_466_3 = var_466_2:GetComponent("SpriteRenderer")

				if var_466_3 and var_466_3.sprite then
					local var_466_4 = 2 * (var_466_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_466_2.transform.localScale = Vector3.New(var_466_4 / var_466_3.sprite.bounds.size.y < var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x and var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x or var_466_4 / var_466_3.sprite.bounds.size.y, var_466_4 / var_466_3.sprite.bounds.size.y < var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x and var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x or var_466_4 / var_466_3.sprite.bounds.size.y, 0)
				end

				for iter_466_0, iter_466_1 in pairs(arg_463_1.bgs_) do
					if iter_466_0 ~= "R5002" then
						iter_466_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_466_5 = 0

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_5 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_6 = 1

			if var_466_5 <= arg_463_1.time_ and arg_463_1.time_ < var_466_5 + var_466_6 then
				local var_466_7 = Color.New(0, 0, 0)

				var_466_7.a = Mathf.Lerp(0, 1, (arg_463_1.time_ - var_466_5) / var_466_6)
				arg_463_1.mask_.color = var_466_7
			end

			if arg_463_1.time_ >= var_466_5 + var_466_6 and arg_463_1.time_ < var_466_5 + var_466_6 + arg_466_0 then
				local var_466_8 = Color.New(0, 0, 0)

				var_466_8.a = 1
				arg_463_1.mask_.color = var_466_8
			end

			local var_466_9 = 1

			if 1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_9 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_10 = 1

			if var_466_9 <= arg_463_1.time_ and arg_463_1.time_ < var_466_9 + var_466_10 then
				local var_466_11 = Color.New(0, 0, 0)

				var_466_11.a = Mathf.Lerp(1, 0, (arg_463_1.time_ - var_466_9) / var_466_10)
				arg_463_1.mask_.color = var_466_11
			end

			if arg_463_1.time_ >= var_466_9 + var_466_10 and arg_463_1.time_ < var_466_9 + var_466_10 + arg_466_0 then
				local var_466_12 = Color.New(0, 0, 0)

				arg_463_1.mask_.enabled = false
				var_466_12.a = 0
				arg_463_1.mask_.color = var_466_12
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_466_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_463_1.bgmTxt_.text ~= var_466_15 and arg_463_1.bgmTxt_.text ~= "" then
						if arg_463_1.bgmTxt2_.text ~= "" then
							arg_463_1.bgmTxt_.text = arg_463_1.bgmTxt2_.text
						end

						arg_463_1.bgmTxt2_.text = var_466_15

						arg_463_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_463_1.bgmTxt_.text = var_466_15
						arg_463_1.bgmTxt2_.text = var_466_15
					end

					if arg_463_1.bgmTimer then
						arg_463_1.bgmTimer:Stop()

						arg_463_1.bgmTimer = nil
					end

					if arg_463_1.settingData.show_music_name == 1 then
						arg_463_1.musicController:SetSelectedState("show")
						arg_463_1.musicAnimator_:Play("open", 0, 0)

						if arg_463_1.settingData.music_time ~= 0 then
							arg_463_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_463_1.settingData.music_time), function()
								if arg_463_1 == nil or isNil(arg_463_1.bgmTxt_) then
									return
								end

								arg_463_1.musicController:SetSelectedState("hide")
								arg_463_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_463_1.time_ and arg_463_1.time_ <= 0.266666666666667 + arg_466_0 then
				arg_463_1:AudioAction("play", "music", "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_466_18 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if "" ~= "" then
					if arg_463_1.bgmTxt_.text ~= var_466_18 and arg_463_1.bgmTxt_.text ~= "" then
						if arg_463_1.bgmTxt2_.text ~= "" then
							arg_463_1.bgmTxt_.text = arg_463_1.bgmTxt2_.text
						end

						arg_463_1.bgmTxt2_.text = var_466_18

						arg_463_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_463_1.bgmTxt_.text = var_466_18
						arg_463_1.bgmTxt2_.text = var_466_18
					end

					if arg_463_1.bgmTimer then
						arg_463_1.bgmTimer:Stop()

						arg_463_1.bgmTimer = nil
					end

					if arg_463_1.settingData.show_music_name == 1 then
						arg_463_1.musicController:SetSelectedState("show")
						arg_463_1.musicAnimator_:Play("open", 0, 0)

						if arg_463_1.settingData.music_time ~= 0 then
							arg_463_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_463_1.settingData.music_time), function()
								if arg_463_1 == nil or isNil(arg_463_1.bgmTxt_) then
									return
								end

								arg_463_1.musicController:SetSelectedState("hide")
								arg_463_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_466_19 = "R5002_blur"

			if arg_463_1.bgs_.R5002_blur == nil then
				local var_466_20 = Object.Instantiate(arg_463_1.blurPaintGo_)

				var_466_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_466_19)
				var_466_20.name = var_466_19
				var_466_20.transform.parent = arg_463_1.stage_.transform
				var_466_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_463_1.bgs_[var_466_19] = var_466_20
			end

			local var_466_21 = 1
			local var_466_22 = arg_463_1.bgs_[var_466_19]

			if 1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_21 + arg_466_0 then
				var_466_22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_466_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_466_23 = var_466_22:GetComponent("SpriteRenderer")

				if var_466_23 and var_466_23.sprite then
					local var_466_24 = 2 * (var_466_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_466_22.transform.localScale = Vector3.New(var_466_24 / var_466_23.sprite.bounds.size.y < var_466_24 * manager.ui.mainCameraCom_.aspect / var_466_23.sprite.bounds.size.x and var_466_24 * manager.ui.mainCameraCom_.aspect / var_466_23.sprite.bounds.size.x or var_466_24 / var_466_23.sprite.bounds.size.y, var_466_24 / var_466_23.sprite.bounds.size.y < var_466_24 * manager.ui.mainCameraCom_.aspect / var_466_23.sprite.bounds.size.x and var_466_24 * manager.ui.mainCameraCom_.aspect / var_466_23.sprite.bounds.size.x or var_466_24 / var_466_23.sprite.bounds.size.y, 0)
				end
			end

			local var_466_25 = 1

			if var_466_21 <= arg_463_1.time_ and arg_463_1.time_ < var_466_21 + var_466_25 then
				local var_466_26 = Color.New(1, 1, 1)

				var_466_26.a = Mathf.Lerp(1, 0, (arg_463_1.time_ - var_466_21) / var_466_25)

				var_466_22:GetComponent("SpriteRenderer").material:SetColor("_Color", var_466_26)
			end

			if arg_463_1.frameCnt_ <= 1 then
				arg_463_1.dialog_:SetActive(false)
			end

			local var_466_27 = 2
			local var_466_28 = 0.6

			if 2 < arg_463_1.time_ and arg_463_1.time_ <= var_466_27 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0

				arg_463_1.dialog_:SetActive(true)

				arg_463_1.dialogCg_.alpha = 0

				local var_466_29 = LeanTween.value(arg_463_1.dialog_, 0, 1, 0.3)

				var_466_29:setOnUpdate(LuaHelper.FloatAction(function(arg_469_0)
					arg_463_1.dialogCg_.alpha = arg_469_0
				end))
				var_466_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_463_1.dialog_)
					var_466_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_463_1.duration_ = arg_463_1.duration_ + 0.3

				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_30 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(1105006111).content)

				arg_463_1.text_.text = var_466_30

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_32 = 24 <= 0 and var_466_28 or var_466_28 * (utf8.len(var_466_30) / 24)

				if (24 <= 0 and var_466_28 or var_466_28 * (utf8.len(var_466_30) / 24)) > 0 and var_466_28 < var_466_32 then
					arg_463_1.talkMaxDuration = var_466_32
					var_466_27 = var_466_27 + 0.3

					if var_466_32 + var_466_27 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_32 + var_466_27
					end
				end

				arg_463_1.text_.text = var_466_30
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_33 = var_466_27 + 0.3
			local var_466_34 = math.max(var_466_28, arg_463_1.talkMaxDuration)

			if var_466_27 + 0.3 <= arg_463_1.time_ and arg_463_1.time_ < var_466_33 + var_466_34 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_33) / var_466_34

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_33 + var_466_34 and arg_463_1.time_ < var_466_33 + var_466_34 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1105006112 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1105006112
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1105006113(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 1.325

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_1 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1105006112).content)

				arg_471_1.text_.text = var_474_1

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_3 = 53 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 53)

				if (53 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 53)) > 0 and var_474_0 < var_474_3 then
					arg_471_1.talkMaxDuration = var_474_3

					if var_474_3 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_3 + 0
					end
				end

				arg_471_1.text_.text = var_474_1
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_4 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_4 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_4

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_4 and arg_471_1.time_ < 0 + var_474_4 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1105006113 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1105006113
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1105006114(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.275

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_1 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(1105006113).content)

				arg_475_1.text_.text = var_478_1

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_3 = 11 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 11)

				if (11 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 11)) > 0 and var_478_0 < var_478_3 then
					arg_475_1.talkMaxDuration = var_478_3

					if var_478_3 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_3 + 0
					end
				end

				arg_475_1.text_.text = var_478_1
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_4 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_4

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1105006114 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1105006114
		arg_479_1.duration_ = 4.8

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1105006115(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.375

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_1 = arg_479_1:GetWordFromCfg(1105006114)
				local var_482_2 = arg_479_1:FormatText(var_482_1.content)

				arg_479_1.text_.text = var_482_2

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 15 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 15)

				if (15 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 15)) > 0 and var_482_0 < var_482_4 then
					arg_479_1.talkMaxDuration = var_482_4

					if var_482_4 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_4 + 0
					end
				end

				arg_479_1.text_.text = var_482_2
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb") ~= 0 then
					local var_482_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb") / 1000

					if var_482_5 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + 0
					end

					if var_482_1.prefab_name ~= "" and arg_479_1.actors_[var_482_1.prefab_name] ~= nil then
						local var_482_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_1.prefab_name].transform, "story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb")

						arg_479_1:RecordAudio("1105006114", var_482_6)
						arg_479_1:RecordAudio("1105006114", var_482_6)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006114", "story_v_side_new_1105006.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1105006115 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1105006115
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1105006116(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 1.025

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(1105006115).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 41 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 41)

				if (41 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 41)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1105006116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1105006116
		arg_487_1.duration_ = 5.67

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1105006117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.625

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:GetWordFromCfg(1105006116)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 25 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 25)

				if (25 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 25)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb")

						arg_487_1:RecordAudio("1105006116", var_490_6)
						arg_487_1:RecordAudio("1105006116", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006116", "story_v_side_new_1105006.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1105006117 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1105006117
		arg_491_1.duration_ = 7.57

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1105006118(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 1.125

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_1 = arg_491_1:GetWordFromCfg(1105006117)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 45 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 45)

				if (45 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 45)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb")

						arg_491_1:RecordAudio("1105006117", var_494_6)
						arg_491_1:RecordAudio("1105006117", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006117", "story_v_side_new_1105006.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1105006118 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1105006118
		arg_495_1.duration_ = 6.87

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1105006119(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.7

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(1105006118)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 28 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 28)

				if (28 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 28)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb")

						arg_495_1:RecordAudio("1105006118", var_498_6)
						arg_495_1:RecordAudio("1105006118", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006118", "story_v_side_new_1105006.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1105006119 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1105006119
		arg_499_1.duration_ = 5.1

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1105006120(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.5

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:GetWordFromCfg(1105006119)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 20 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 20)

				if (20 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 20)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb")

						arg_499_1:RecordAudio("1105006119", var_502_6)
						arg_499_1:RecordAudio("1105006119", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006119", "story_v_side_new_1105006.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1105006120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1105006120
		arg_503_1.duration_ = 6.83

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1105006121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.7

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:GetWordFromCfg(1105006120)
				local var_506_2 = arg_503_1:FormatText(var_506_1.content)

				arg_503_1.text_.text = var_506_2

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 28 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 28)

				if (28 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 28)) > 0 and var_506_0 < var_506_4 then
					arg_503_1.talkMaxDuration = var_506_4

					if var_506_4 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_4 + 0
					end
				end

				arg_503_1.text_.text = var_506_2
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb") ~= 0 then
					local var_506_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb") / 1000

					if var_506_5 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + 0
					end

					if var_506_1.prefab_name ~= "" and arg_503_1.actors_[var_506_1.prefab_name] ~= nil then
						local var_506_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_1.prefab_name].transform, "story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb")

						arg_503_1:RecordAudio("1105006120", var_506_6)
						arg_503_1:RecordAudio("1105006120", var_506_6)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006120", "story_v_side_new_1105006.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1105006121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1105006121
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1105006122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.35

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(1105006121).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 14 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 14)

				if (14 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 14)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1105006122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1105006122
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1105006123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.625

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(1105006122).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 25 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 25)

				if (25 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 25)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1105006123 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1105006123
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1105006124(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.525

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(1105006123).content)

				arg_515_1.text_.text = var_518_1

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_3 = 21 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 21)

				if (21 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 21)) > 0 and var_518_0 < var_518_3 then
					arg_515_1.talkMaxDuration = var_518_3

					if var_518_3 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_3 + 0
					end
				end

				arg_515_1.text_.text = var_518_1
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_4 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_4

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1105006124 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1105006124
		arg_519_1.duration_ = 1.33

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1105006125(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.125

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_1 = arg_519_1:GetWordFromCfg(1105006124)
				local var_522_2 = arg_519_1:FormatText(var_522_1.content)

				arg_519_1.text_.text = var_522_2

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_4 = 5 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 5)

				if (5 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 5)) > 0 and var_522_0 < var_522_4 then
					arg_519_1.talkMaxDuration = var_522_4

					if var_522_4 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_4 + 0
					end
				end

				arg_519_1.text_.text = var_522_2
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb") ~= 0 then
					local var_522_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb") / 1000

					if var_522_5 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + 0
					end

					if var_522_1.prefab_name ~= "" and arg_519_1.actors_[var_522_1.prefab_name] ~= nil then
						local var_522_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_1.prefab_name].transform, "story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb")

						arg_519_1:RecordAudio("1105006124", var_522_6)
						arg_519_1:RecordAudio("1105006124", var_522_6)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006124", "story_v_side_new_1105006.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_7 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_7

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1105006125 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1105006125
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1105006126(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 1.075

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1105006125).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 43 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 43)

				if (43 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 43)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1105006126 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1105006126
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1105006127(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 1.05

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1105006126).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 42 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 42)

				if (42 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 42)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1105006127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1105006127
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1105006128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.275

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_1 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(1105006127).content)

				arg_531_1.text_.text = var_534_1

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_3 = 11 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 11)

				if (11 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 11)) > 0 and var_534_0 < var_534_3 then
					arg_531_1.talkMaxDuration = var_534_3

					if var_534_3 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_3 + 0
					end
				end

				arg_531_1.text_.text = var_534_1
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_4 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_4

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1105006128 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1105006128
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1105006129(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.775

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_1 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1105006128).content)

				arg_535_1.text_.text = var_538_1

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_3 = 31 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 31)

				if (31 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 31)) > 0 and var_538_0 < var_538_3 then
					arg_535_1.talkMaxDuration = var_538_3

					if var_538_3 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_3 + 0
					end
				end

				arg_535_1.text_.text = var_538_1
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_4 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_4

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1105006129 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1105006129
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1105006130(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0.225

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_1 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(1105006129).content)

				arg_539_1.text_.text = var_542_1

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_3 = 9 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 9)

				if (9 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 9)) > 0 and var_542_0 < var_542_3 then
					arg_539_1.talkMaxDuration = var_542_3

					if var_542_3 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_3 + 0
					end
				end

				arg_539_1.text_.text = var_542_1
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_4 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_4 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_4

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_4 and arg_539_1.time_ < 0 + var_542_4 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1105006130 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1105006130
		arg_543_1.duration_ = 1

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"

			SetActive(arg_543_1.choicesGo_, true)

			for iter_544_0, iter_544_1 in ipairs(arg_543_1.choices_) do
				SetActive(iter_544_1.go, iter_544_0 <= 2)
			end

			arg_543_1.choices_[1].txt.text = arg_543_1:FormatText(StoryChoiceCfg[1066].name)
			arg_543_1.choices_[2].txt.text = arg_543_1:FormatText(StoryChoiceCfg[1067].name)
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1105006131(arg_543_1)
			end

			if arg_545_0 == 2 then
				arg_543_0:Play1105006131(arg_543_1)
			end

			arg_543_1:RecordChoiceLog(1105006130, 1066, 1067)
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.allBtn_.enabled = false
			end

			if arg_543_1.time_ >= 0 + 0.6 and arg_543_1.time_ < 0 + 0.6 + arg_546_0 then
				arg_543_1.allBtn_.enabled = true
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1105006131 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1105006131
		arg_547_1.duration_ = 8.99

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1105006132(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if arg_547_1.bgs_.R5002a == nil then
				local var_550_0 = Object.Instantiate(arg_547_1.paintGo_)

				var_550_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R5002a")
				var_550_0.name = "R5002a"
				var_550_0.transform.parent = arg_547_1.stage_.transform
				var_550_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_547_1.bgs_.R5002a = var_550_0
			end

			if 1.93333333333333 < arg_547_1.time_ and arg_547_1.time_ <= 1.93333333333333 + arg_550_0 then
				local var_550_1 = arg_547_1.bgs_.R5002a

				arg_547_1.bgs_.R5002a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_550_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_550_2 = var_550_1:GetComponent("SpriteRenderer")

				if var_550_2 and var_550_2.sprite then
					local var_550_3 = 2 * (var_550_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_550_1.transform.localScale = Vector3.New(var_550_3 / var_550_2.sprite.bounds.size.y < var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x and var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x or var_550_3 / var_550_2.sprite.bounds.size.y, var_550_3 / var_550_2.sprite.bounds.size.y < var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x and var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x or var_550_3 / var_550_2.sprite.bounds.size.y, 0)
				end

				for iter_550_0, iter_550_1 in pairs(arg_547_1.bgs_) do
					if iter_550_0 ~= "R5002a" then
						iter_550_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_550_4 = 3.9884612034075

			if 3.9884612034075 < arg_547_1.time_ and arg_547_1.time_ <= var_550_4 + arg_550_0 then
				arg_547_1.allBtn_.enabled = false
			end

			if arg_547_1.time_ >= var_550_4 + 0.3 and arg_547_1.time_ < var_550_4 + 0.3 + arg_550_0 then
				arg_547_1.allBtn_.enabled = true
			end

			local var_550_5 = 0

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_5 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_6 = 2

			if var_550_5 <= arg_547_1.time_ and arg_547_1.time_ < var_550_5 + var_550_6 then
				local var_550_7 = Color.New(0, 0, 0)

				var_550_7.a = Mathf.Lerp(0, 1, (arg_547_1.time_ - var_550_5) / var_550_6)
				arg_547_1.mask_.color = var_550_7
			end

			if arg_547_1.time_ >= var_550_5 + var_550_6 and arg_547_1.time_ < var_550_5 + var_550_6 + arg_550_0 then
				local var_550_8 = Color.New(0, 0, 0)

				var_550_8.a = 1
				arg_547_1.mask_.color = var_550_8
			end

			local var_550_9 = 2

			if 2 < arg_547_1.time_ and arg_547_1.time_ <= var_550_9 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_10 = 2

			if var_550_9 <= arg_547_1.time_ and arg_547_1.time_ < var_550_9 + var_550_10 then
				local var_550_11 = Color.New(0, 0, 0)

				var_550_11.a = Mathf.Lerp(1, 0, (arg_547_1.time_ - var_550_9) / var_550_10)
				arg_547_1.mask_.color = var_550_11
			end

			if arg_547_1.time_ >= var_550_9 + var_550_10 and arg_547_1.time_ < var_550_9 + var_550_10 + arg_550_0 then
				local var_550_12 = Color.New(0, 0, 0)

				arg_547_1.mask_.enabled = false
				var_550_12.a = 0
				arg_547_1.mask_.color = var_550_12
			end

			local var_550_13 = arg_547_1.bgs_.R5002a.transform

			if 2 < arg_547_1.time_ and arg_547_1.time_ <= 2 + arg_550_0 then
				arg_547_1.var_.moveOldPosR5002a = var_550_13.localPosition
			end

			local var_550_14 = 0.001

			if 2 <= arg_547_1.time_ and arg_547_1.time_ < 2 + var_550_14 then
				var_550_13.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosR5002a, Vector3.New(3, -0.25, 3), (arg_547_1.time_ - 2) / var_550_14)
			end

			if arg_547_1.time_ >= 2 + var_550_14 and arg_547_1.time_ < 2 + var_550_14 + arg_550_0 then
				var_550_13.localPosition = Vector3.New(3, -0.25, 3)
			end

			local var_550_15 = arg_547_1.bgs_.R5002a.transform

			if 2.01666666666667 < arg_547_1.time_ and arg_547_1.time_ <= 2.01666666666667 + arg_550_0 then
				arg_547_1.var_.moveOldPosR5002a = var_550_15.localPosition
			end

			local var_550_16 = 5

			if 2.01666666666667 <= arg_547_1.time_ and arg_547_1.time_ < 2.01666666666667 + var_550_16 then
				var_550_15.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosR5002a, Vector3.New(3, 0.25, 3), (arg_547_1.time_ - 2.01666666666667) / var_550_16)
			end

			if arg_547_1.time_ >= 2.01666666666667 + var_550_16 and arg_547_1.time_ < 2.01666666666667 + var_550_16 + arg_550_0 then
				var_550_15.localPosition = Vector3.New(3, 0.25, 3)
			end

			local var_550_17 = 3.9884612034075

			if 3.9884612034075 < arg_547_1.time_ and arg_547_1.time_ <= var_550_17 + arg_550_0 then
				arg_547_1.allBtn_.enabled = false
			end

			if arg_547_1.time_ >= var_550_17 + 3.02820546325917 and arg_547_1.time_ < var_550_17 + 3.02820546325917 + arg_550_0 then
				arg_547_1.allBtn_.enabled = true
			end

			if arg_547_1.frameCnt_ <= 1 then
				arg_547_1.dialog_:SetActive(false)
			end

			local var_550_18 = 3.9884612034075
			local var_550_19 = 1.025

			if 3.9884612034075 < arg_547_1.time_ and arg_547_1.time_ <= var_550_18 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0

				arg_547_1.dialog_:SetActive(true)

				arg_547_1.dialogCg_.alpha = 0

				local var_550_20 = LeanTween.value(arg_547_1.dialog_, 0, 1, 0.3)

				var_550_20:setOnUpdate(LuaHelper.FloatAction(function(arg_551_0)
					arg_547_1.dialogCg_.alpha = arg_551_0
				end))
				var_550_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_547_1.dialog_)
					var_550_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_547_1.duration_ = arg_547_1.duration_ + 0.3

				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_21 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(1105006131).content)

				arg_547_1.text_.text = var_550_21

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_23 = 41 <= 0 and var_550_19 or var_550_19 * (utf8.len(var_550_21) / 41)

				if (41 <= 0 and var_550_19 or var_550_19 * (utf8.len(var_550_21) / 41)) > 0 and var_550_19 < var_550_23 then
					arg_547_1.talkMaxDuration = var_550_23
					var_550_18 = var_550_18 + 0.3

					if var_550_23 + var_550_18 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_23 + var_550_18
					end
				end

				arg_547_1.text_.text = var_550_21
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_24 = var_550_18 + 0.3
			local var_550_25 = math.max(var_550_19, arg_547_1.talkMaxDuration)

			if var_550_18 + 0.3 <= arg_547_1.time_ and arg_547_1.time_ < var_550_24 + var_550_25 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_24) / var_550_25

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_24 + var_550_25 and arg_547_1.time_ < var_550_24 + var_550_25 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play1105006132 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1105006132
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1105006133(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 1.175

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_1 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(1105006132).content)

				arg_553_1.text_.text = var_556_1

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_3 = 47 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 47)

				if (47 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 47)) > 0 and var_556_0 < var_556_3 then
					arg_553_1.talkMaxDuration = var_556_3

					if var_556_3 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_3 + 0
					end
				end

				arg_553_1.text_.text = var_556_1
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_4 = math.max(var_556_0, arg_553_1.talkMaxDuration)

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - 0) / var_556_4

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1105006133 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1105006133
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1105006134(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.45

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_1 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(1105006133).content)

				arg_557_1.text_.text = var_560_1

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_3 = 18 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 18)

				if (18 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 18)) > 0 and var_560_0 < var_560_3 then
					arg_557_1.talkMaxDuration = var_560_3

					if var_560_3 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_3 + 0
					end
				end

				arg_557_1.text_.text = var_560_1
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_4 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_4 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_4

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_4 and arg_557_1.time_ < 0 + var_560_4 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1105006134 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1105006134
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1105006135(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.475

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_1 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(1105006134).content)

				arg_561_1.text_.text = var_564_1

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_3 = 19 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 19)

				if (19 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 19)) > 0 and var_564_0 < var_564_3 then
					arg_561_1.talkMaxDuration = var_564_3

					if var_564_3 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_3 + 0
					end
				end

				arg_561_1.text_.text = var_564_1
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_4 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_4

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1105006135 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1105006135
		arg_565_1.duration_ = 1.4

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1105006136(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0.15

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_1 = arg_565_1:GetWordFromCfg(1105006135)
				local var_568_2 = arg_565_1:FormatText(var_568_1.content)

				arg_565_1.text_.text = var_568_2

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_4 = 6 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 6)

				if (6 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 6)) > 0 and var_568_0 < var_568_4 then
					arg_565_1.talkMaxDuration = var_568_4

					if var_568_4 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_4 + 0
					end
				end

				arg_565_1.text_.text = var_568_2
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb") ~= 0 then
					local var_568_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb") / 1000

					if var_568_5 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + 0
					end

					if var_568_1.prefab_name ~= "" and arg_565_1.actors_[var_568_1.prefab_name] ~= nil then
						local var_568_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_1.prefab_name].transform, "story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb")

						arg_565_1:RecordAudio("1105006135", var_568_6)
						arg_565_1:RecordAudio("1105006135", var_568_6)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006135", "story_v_side_new_1105006.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_7 = math.max(var_568_0, arg_565_1.talkMaxDuration)

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_7 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - 0) / var_568_7

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= 0 + var_568_7 and arg_565_1.time_ < 0 + var_568_7 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1105006136 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1105006136
		arg_569_1.duration_ = 3.43

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1105006137(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.425

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_1 = arg_569_1:GetWordFromCfg(1105006136)
				local var_572_2 = arg_569_1:FormatText(var_572_1.content)

				arg_569_1.text_.text = var_572_2

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_4 = 17 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 17)

				if (17 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 17)) > 0 and var_572_0 < var_572_4 then
					arg_569_1.talkMaxDuration = var_572_4

					if var_572_4 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_4 + 0
					end
				end

				arg_569_1.text_.text = var_572_2
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb") ~= 0 then
					local var_572_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb") / 1000

					if var_572_5 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + 0
					end

					if var_572_1.prefab_name ~= "" and arg_569_1.actors_[var_572_1.prefab_name] ~= nil then
						local var_572_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_1.prefab_name].transform, "story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb")

						arg_569_1:RecordAudio("1105006136", var_572_6)
						arg_569_1:RecordAudio("1105006136", var_572_6)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006136", "story_v_side_new_1105006.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_7 and arg_569_1.time_ < 0 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1105006137 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1105006137
		arg_573_1.duration_ = 1.2

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1105006138(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0.125

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_1 = arg_573_1:GetWordFromCfg(1105006137)
				local var_576_2 = arg_573_1:FormatText(var_576_1.content)

				arg_573_1.text_.text = var_576_2

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_4 = 5 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 5)

				if (5 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 5)) > 0 and var_576_0 < var_576_4 then
					arg_573_1.talkMaxDuration = var_576_4

					if var_576_4 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_4 + 0
					end
				end

				arg_573_1.text_.text = var_576_2
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb") ~= 0 then
					local var_576_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb") / 1000

					if var_576_5 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + 0
					end

					if var_576_1.prefab_name ~= "" and arg_573_1.actors_[var_576_1.prefab_name] ~= nil then
						local var_576_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_1.prefab_name].transform, "story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb")

						arg_573_1:RecordAudio("1105006137", var_576_6)
						arg_573_1:RecordAudio("1105006137", var_576_6)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006137", "story_v_side_new_1105006.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_7 = math.max(var_576_0, arg_573_1.talkMaxDuration)

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_7 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - 0) / var_576_7

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= 0 + var_576_7 and arg_573_1.time_ < 0 + var_576_7 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1105006138 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1105006138
		arg_577_1.duration_ = 6.87

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1105006139(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if arg_577_1.bgs_.STblack == nil then
				local var_580_0 = Object.Instantiate(arg_577_1.paintGo_)

				var_580_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_580_0.name = "STblack"
				var_580_0.transform.parent = arg_577_1.stage_.transform
				var_580_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_577_1.bgs_.STblack = var_580_0
			end

			if 1 < arg_577_1.time_ and arg_577_1.time_ <= 1 + arg_580_0 then
				local var_580_1 = arg_577_1.bgs_.STblack

				arg_577_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_580_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_580_2 = var_580_1:GetComponent("SpriteRenderer")

				if var_580_2 and var_580_2.sprite then
					local var_580_3 = 2 * (var_580_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_580_1.transform.localScale = Vector3.New(var_580_3 / var_580_2.sprite.bounds.size.y < var_580_3 * manager.ui.mainCameraCom_.aspect / var_580_2.sprite.bounds.size.x and var_580_3 * manager.ui.mainCameraCom_.aspect / var_580_2.sprite.bounds.size.x or var_580_3 / var_580_2.sprite.bounds.size.y, var_580_3 / var_580_2.sprite.bounds.size.y < var_580_3 * manager.ui.mainCameraCom_.aspect / var_580_2.sprite.bounds.size.x and var_580_3 * manager.ui.mainCameraCom_.aspect / var_580_2.sprite.bounds.size.x or var_580_3 / var_580_2.sprite.bounds.size.y, 0)
				end

				for iter_580_0, iter_580_1 in pairs(arg_577_1.bgs_) do
					if iter_580_0 ~= "STblack" then
						iter_580_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_580_4 = 0

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_4 + arg_580_0 then
				arg_577_1.mask_.enabled = true
				arg_577_1.mask_.raycastTarget = true

				arg_577_1:SetGaussion(false)
			end

			local var_580_5 = 1

			if var_580_4 <= arg_577_1.time_ and arg_577_1.time_ < var_580_4 + var_580_5 then
				local var_580_6 = Color.New(0, 0, 0)

				var_580_6.a = Mathf.Lerp(0, 1, (arg_577_1.time_ - var_580_4) / var_580_5)
				arg_577_1.mask_.color = var_580_6
			end

			if arg_577_1.time_ >= var_580_4 + var_580_5 and arg_577_1.time_ < var_580_4 + var_580_5 + arg_580_0 then
				local var_580_7 = Color.New(0, 0, 0)

				var_580_7.a = 1
				arg_577_1.mask_.color = var_580_7
			end

			local var_580_8 = 1

			if 1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_8 + arg_580_0 then
				arg_577_1.mask_.enabled = true
				arg_577_1.mask_.raycastTarget = true

				arg_577_1:SetGaussion(false)
			end

			local var_580_9 = 1

			if var_580_8 <= arg_577_1.time_ and arg_577_1.time_ < var_580_8 + var_580_9 then
				local var_580_10 = Color.New(0, 0, 0)

				var_580_10.a = Mathf.Lerp(1, 0, (arg_577_1.time_ - var_580_8) / var_580_9)
				arg_577_1.mask_.color = var_580_10
			end

			if arg_577_1.time_ >= var_580_8 + var_580_9 and arg_577_1.time_ < var_580_8 + var_580_9 + arg_580_0 then
				local var_580_11 = Color.New(0, 0, 0)

				arg_577_1.mask_.enabled = false
				var_580_11.a = 0
				arg_577_1.mask_.color = var_580_11
			end

			if arg_577_1.frameCnt_ <= 1 then
				arg_577_1.dialog_:SetActive(false)
			end

			local var_580_12 = 1.86666666666667
			local var_580_13 = 0.625

			if 1.86666666666667 < arg_577_1.time_ and arg_577_1.time_ <= var_580_12 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0

				arg_577_1.dialog_:SetActive(true)

				arg_577_1.dialogCg_.alpha = 0

				local var_580_14 = LeanTween.value(arg_577_1.dialog_, 0, 1, 0.3)

				var_580_14:setOnUpdate(LuaHelper.FloatAction(function(arg_581_0)
					arg_577_1.dialogCg_.alpha = arg_581_0
				end))
				var_580_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_577_1.dialog_)
					var_580_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_577_1.duration_ = arg_577_1.duration_ + 0.3

				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_15 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(1105006138).content)

				arg_577_1.text_.text = var_580_15

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_17 = 25 <= 0 and var_580_13 or var_580_13 * (utf8.len(var_580_15) / 25)

				if (25 <= 0 and var_580_13 or var_580_13 * (utf8.len(var_580_15) / 25)) > 0 and var_580_13 < var_580_17 then
					arg_577_1.talkMaxDuration = var_580_17
					var_580_12 = var_580_12 + 0.3

					if var_580_17 + var_580_12 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_17 + var_580_12
					end
				end

				arg_577_1.text_.text = var_580_15
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_18 = var_580_12 + 0.3
			local var_580_19 = math.max(var_580_13, arg_577_1.talkMaxDuration)

			if var_580_12 + 0.3 <= arg_577_1.time_ and arg_577_1.time_ < var_580_18 + var_580_19 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_18) / var_580_19

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_18 + var_580_19 and arg_577_1.time_ < var_580_18 + var_580_19 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1105006139 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1105006139
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1105006140(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.9

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_1 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(1105006139).content)

				arg_583_1.text_.text = var_586_1

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_3 = 36 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 36)

				if (36 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 36)) > 0 and var_586_0 < var_586_3 then
					arg_583_1.talkMaxDuration = var_586_3

					if var_586_3 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_3 + 0
					end
				end

				arg_583_1.text_.text = var_586_1
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_4 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_4 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_4

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_4 and arg_583_1.time_ < 0 + var_586_4 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1105006140 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1105006140
		arg_587_1.duration_ = 7

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1105006141(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.mask_.enabled = true
				arg_587_1.mask_.raycastTarget = true

				arg_587_1:SetGaussion(false)
			end

			local var_590_0 = 2

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 then
				local var_590_1 = Color.New(0, 0, 0)

				var_590_1.a = Mathf.Lerp(1, 0, (arg_587_1.time_ - 0) / var_590_0)
				arg_587_1.mask_.color = var_590_1
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 then
				local var_590_2 = Color.New(0, 0, 0)

				arg_587_1.mask_.enabled = false
				var_590_2.a = 0
				arg_587_1.mask_.color = var_590_2
			end

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				local var_590_3 = arg_587_1.bgs_.R5002a

				arg_587_1.bgs_.R5002a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_590_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_590_4 = var_590_3:GetComponent("SpriteRenderer")

				if var_590_4 and var_590_4.sprite then
					local var_590_5 = 2 * (var_590_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_590_3.transform.localScale = Vector3.New(var_590_5 / var_590_4.sprite.bounds.size.y < var_590_5 * manager.ui.mainCameraCom_.aspect / var_590_4.sprite.bounds.size.x and var_590_5 * manager.ui.mainCameraCom_.aspect / var_590_4.sprite.bounds.size.x or var_590_5 / var_590_4.sprite.bounds.size.y, var_590_5 / var_590_4.sprite.bounds.size.y < var_590_5 * manager.ui.mainCameraCom_.aspect / var_590_4.sprite.bounds.size.x and var_590_5 * manager.ui.mainCameraCom_.aspect / var_590_4.sprite.bounds.size.x or var_590_5 / var_590_4.sprite.bounds.size.y, 0)
				end

				for iter_590_0, iter_590_1 in pairs(arg_587_1.bgs_) do
					if iter_590_0 ~= "R5002a" then
						iter_590_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_590_6 = arg_587_1.bgs_.R5002a.transform

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPosR5002a = var_590_6.localPosition
			end

			local var_590_7 = 0.0666666666666667

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_7 then
				var_590_6.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPosR5002a, Vector3.New(0, 1, 9.5), (arg_587_1.time_ - 0) / var_590_7)
			end

			if arg_587_1.time_ >= 0 + var_590_7 and arg_587_1.time_ < 0 + var_590_7 + arg_590_0 then
				var_590_6.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_590_8 = arg_587_1.bgs_.R5002a.transform

			if 0.0666666666666667 < arg_587_1.time_ and arg_587_1.time_ <= 0.0666666666666667 + arg_590_0 then
				arg_587_1.var_.moveOldPosR5002a = var_590_8.localPosition
			end

			local var_590_9 = 1.93333333333333

			if 0.0666666666666667 <= arg_587_1.time_ and arg_587_1.time_ < 0.0666666666666667 + var_590_9 then
				var_590_8.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPosR5002a, Vector3.New(0, 1, 10), (arg_587_1.time_ - 0.0666666666666667) / var_590_9)
			end

			if arg_587_1.time_ >= 0.0666666666666667 + var_590_9 and arg_587_1.time_ < 0.0666666666666667 + var_590_9 + arg_590_0 then
				var_590_8.localPosition = Vector3.New(0, 1, 10)
			end

			local var_590_10 = 2
			local var_590_11 = 0.675

			if 2 < arg_587_1.time_ and arg_587_1.time_ <= var_590_10 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_12 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(1105006140).content)

				arg_587_1.text_.text = var_590_12

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_14 = 27 <= 0 and var_590_11 or var_590_11 * (utf8.len(var_590_12) / 27)

				if (27 <= 0 and var_590_11 or var_590_11 * (utf8.len(var_590_12) / 27)) > 0 and var_590_11 < var_590_14 then
					arg_587_1.talkMaxDuration = var_590_14

					if var_590_14 + var_590_10 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_14 + var_590_10
					end
				end

				arg_587_1.text_.text = var_590_12
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_15 = math.max(var_590_11, arg_587_1.talkMaxDuration)

			if var_590_10 <= arg_587_1.time_ and arg_587_1.time_ < var_590_10 + var_590_15 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_10) / var_590_15

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_10 + var_590_15 and arg_587_1.time_ < var_590_10 + var_590_15 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R5002a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93333333333333,
				className = "StoryMoveNode",
				startTime = 0.0666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play1105006141 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1105006141
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1105006142(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.3

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(1105006141).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 12 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 12)

				if (12 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 12)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1105006142 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1105006142
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1105006143(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.85

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_1 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(1105006142).content)

				arg_595_1.text_.text = var_598_1

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_3 = 34 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 34)

				if (34 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 34)) > 0 and var_598_0 < var_598_3 then
					arg_595_1.talkMaxDuration = var_598_3

					if var_598_3 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_3 + 0
					end
				end

				arg_595_1.text_.text = var_598_1
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_4 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_4 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_4

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_4 and arg_595_1.time_ < 0 + var_598_4 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1105006143 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1105006143
		arg_599_1.duration_ = 1.43

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1105006144(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0.15

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_1 = arg_599_1:GetWordFromCfg(1105006143)
				local var_602_2 = arg_599_1:FormatText(var_602_1.content)

				arg_599_1.text_.text = var_602_2

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_4 = 6 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 6)

				if (6 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 6)) > 0 and var_602_0 < var_602_4 then
					arg_599_1.talkMaxDuration = var_602_4

					if var_602_4 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_4 + 0
					end
				end

				arg_599_1.text_.text = var_602_2
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb") ~= 0 then
					local var_602_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb") / 1000

					if var_602_5 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_5 + 0
					end

					if var_602_1.prefab_name ~= "" and arg_599_1.actors_[var_602_1.prefab_name] ~= nil then
						local var_602_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_1.prefab_name].transform, "story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb")

						arg_599_1:RecordAudio("1105006143", var_602_6)
						arg_599_1:RecordAudio("1105006143", var_602_6)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006143", "story_v_side_new_1105006.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_7 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_7 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_7

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_7 and arg_599_1.time_ < 0 + var_602_7 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1105006144 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1105006144
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1105006145(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0.725

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_1 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(1105006144).content)

				arg_603_1.text_.text = var_606_1

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_3 = 29 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_1) / 29)

				if (29 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_1) / 29)) > 0 and var_606_0 < var_606_3 then
					arg_603_1.talkMaxDuration = var_606_3

					if var_606_3 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_3 + 0
					end
				end

				arg_603_1.text_.text = var_606_1
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_4 = math.max(var_606_0, arg_603_1.talkMaxDuration)

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_4 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - 0) / var_606_4

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= 0 + var_606_4 and arg_603_1.time_ < 0 + var_606_4 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1105006145 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1105006145
		arg_607_1.duration_ = 7.7

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1105006146(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 2 < arg_607_1.time_ and arg_607_1.time_ <= 2 + arg_610_0 then
				local var_610_0 = arg_607_1.bgs_.STblack

				arg_607_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_610_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_610_1 = var_610_0:GetComponent("SpriteRenderer")

				if var_610_1 and var_610_1.sprite then
					local var_610_2 = 2 * (var_610_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_610_0.transform.localScale = Vector3.New(var_610_2 / var_610_1.sprite.bounds.size.y < var_610_2 * manager.ui.mainCameraCom_.aspect / var_610_1.sprite.bounds.size.x and var_610_2 * manager.ui.mainCameraCom_.aspect / var_610_1.sprite.bounds.size.x or var_610_2 / var_610_1.sprite.bounds.size.y, var_610_2 / var_610_1.sprite.bounds.size.y < var_610_2 * manager.ui.mainCameraCom_.aspect / var_610_1.sprite.bounds.size.x and var_610_2 * manager.ui.mainCameraCom_.aspect / var_610_1.sprite.bounds.size.x or var_610_2 / var_610_1.sprite.bounds.size.y, 0)
				end

				for iter_610_0, iter_610_1 in pairs(arg_607_1.bgs_) do
					if iter_610_0 ~= "STblack" then
						iter_610_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_610_3 = 0

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_3 + arg_610_0 then
				arg_607_1.mask_.enabled = true
				arg_607_1.mask_.raycastTarget = true

				arg_607_1:SetGaussion(false)
			end

			local var_610_4 = 2

			if var_610_3 <= arg_607_1.time_ and arg_607_1.time_ < var_610_3 + var_610_4 then
				local var_610_5 = Color.New(0, 0, 0)

				var_610_5.a = Mathf.Lerp(0, 1, (arg_607_1.time_ - var_610_3) / var_610_4)
				arg_607_1.mask_.color = var_610_5
			end

			if arg_607_1.time_ >= var_610_3 + var_610_4 and arg_607_1.time_ < var_610_3 + var_610_4 + arg_610_0 then
				local var_610_6 = Color.New(0, 0, 0)

				var_610_6.a = 1
				arg_607_1.mask_.color = var_610_6
			end

			local var_610_7 = 2

			if 2 < arg_607_1.time_ and arg_607_1.time_ <= var_610_7 + arg_610_0 then
				arg_607_1.mask_.enabled = true
				arg_607_1.mask_.raycastTarget = true

				arg_607_1:SetGaussion(false)
			end

			local var_610_8 = 2

			if var_610_7 <= arg_607_1.time_ and arg_607_1.time_ < var_610_7 + var_610_8 then
				local var_610_9 = Color.New(0, 0, 0)

				var_610_9.a = Mathf.Lerp(1, 0, (arg_607_1.time_ - var_610_7) / var_610_8)
				arg_607_1.mask_.color = var_610_9
			end

			if arg_607_1.time_ >= var_610_7 + var_610_8 and arg_607_1.time_ < var_610_7 + var_610_8 + arg_610_0 then
				local var_610_10 = Color.New(0, 0, 0)

				arg_607_1.mask_.enabled = false
				var_610_10.a = 0
				arg_607_1.mask_.color = var_610_10
			end

			if arg_607_1.frameCnt_ <= 1 then
				arg_607_1.dialog_:SetActive(false)
			end

			local var_610_11 = 2.7
			local var_610_12 = 1.3

			if 2.7 < arg_607_1.time_ and arg_607_1.time_ <= var_610_11 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0

				arg_607_1.dialog_:SetActive(true)

				arg_607_1.dialogCg_.alpha = 0

				local var_610_13 = LeanTween.value(arg_607_1.dialog_, 0, 1, 0.3)

				var_610_13:setOnUpdate(LuaHelper.FloatAction(function(arg_611_0)
					arg_607_1.dialogCg_.alpha = arg_611_0
				end))
				var_610_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_607_1.dialog_)
					var_610_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_607_1.duration_ = arg_607_1.duration_ + 0.3

				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_14 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(1105006145).content)

				arg_607_1.text_.text = var_610_14

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_16 = 52 <= 0 and var_610_12 or var_610_12 * (utf8.len(var_610_14) / 52)

				if (52 <= 0 and var_610_12 or var_610_12 * (utf8.len(var_610_14) / 52)) > 0 and var_610_12 < var_610_16 then
					arg_607_1.talkMaxDuration = var_610_16
					var_610_11 = var_610_11 + 0.3

					if var_610_16 + var_610_11 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_16 + var_610_11
					end
				end

				arg_607_1.text_.text = var_610_14
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_17 = var_610_11 + 0.3
			local var_610_18 = math.max(var_610_12, arg_607_1.talkMaxDuration)

			if var_610_11 + 0.3 <= arg_607_1.time_ and arg_607_1.time_ < var_610_17 + var_610_18 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_17) / var_610_18

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_17 + var_610_18 and arg_607_1.time_ < var_610_17 + var_610_18 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1105006146 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1105006146
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1105006147(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0.15

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_1 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1105006146).content)

				arg_613_1.text_.text = var_616_1

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_3 = 6 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 6)

				if (6 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 6)) > 0 and var_616_0 < var_616_3 then
					arg_613_1.talkMaxDuration = var_616_3

					if var_616_3 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_3 + 0
					end
				end

				arg_613_1.text_.text = var_616_1
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_4 = math.max(var_616_0, arg_613_1.talkMaxDuration)

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_4 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - 0) / var_616_4

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= 0 + var_616_4 and arg_613_1.time_ < 0 + var_616_4 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1105006147 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1105006147
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1105006148(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 1.575

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_1 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(1105006147).content)

				arg_617_1.text_.text = var_620_1

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_3 = 63 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_1) / 63)

				if (63 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_1) / 63)) > 0 and var_620_0 < var_620_3 then
					arg_617_1.talkMaxDuration = var_620_3

					if var_620_3 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_3 + 0
					end
				end

				arg_617_1.text_.text = var_620_1
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_4 = math.max(var_620_0, arg_617_1.talkMaxDuration)

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_4 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - 0) / var_620_4

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= 0 + var_620_4 and arg_617_1.time_ < 0 + var_620_4 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1105006148 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1105006148
		arg_621_1.duration_ = 5.1

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1105006149(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0.35

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_1 = arg_621_1:GetWordFromCfg(1105006148)
				local var_624_2 = arg_621_1:FormatText(var_624_1.content)

				arg_621_1.text_.text = var_624_2

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_4 = 14 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 14)

				if (14 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 14)) > 0 and var_624_0 < var_624_4 then
					arg_621_1.talkMaxDuration = var_624_4

					if var_624_4 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_4 + 0
					end
				end

				arg_621_1.text_.text = var_624_2
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb") ~= 0 then
					local var_624_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb") / 1000

					if var_624_5 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + 0
					end

					if var_624_1.prefab_name ~= "" and arg_621_1.actors_[var_624_1.prefab_name] ~= nil then
						local var_624_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_1.prefab_name].transform, "story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb")

						arg_621_1:RecordAudio("1105006148", var_624_6)
						arg_621_1:RecordAudio("1105006148", var_624_6)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006148", "story_v_side_new_1105006.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_7 = math.max(var_624_0, arg_621_1.talkMaxDuration)

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_7 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - 0) / var_624_7

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= 0 + var_624_7 and arg_621_1.time_ < 0 + var_624_7 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1105006149 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1105006149
		arg_625_1.duration_ = 6.8

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1105006150(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.7

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_1 = arg_625_1:GetWordFromCfg(1105006149)
				local var_628_2 = arg_625_1:FormatText(var_628_1.content)

				arg_625_1.text_.text = var_628_2

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_4 = 28 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 28)

				if (28 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 28)) > 0 and var_628_0 < var_628_4 then
					arg_625_1.talkMaxDuration = var_628_4

					if var_628_4 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_4 + 0
					end
				end

				arg_625_1.text_.text = var_628_2
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb") ~= 0 then
					local var_628_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb") / 1000

					if var_628_5 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_5 + 0
					end

					if var_628_1.prefab_name ~= "" and arg_625_1.actors_[var_628_1.prefab_name] ~= nil then
						local var_628_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_1.prefab_name].transform, "story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb")

						arg_625_1:RecordAudio("1105006149", var_628_6)
						arg_625_1:RecordAudio("1105006149", var_628_6)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006149", "story_v_side_new_1105006.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_7 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_7 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_7

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_7 and arg_625_1.time_ < 0 + var_628_7 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1105006150 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1105006150
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1105006151(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0.3

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, true)
				arg_629_1.iconController_:SetSelectedState("hero")

				arg_629_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_629_1.callingController_:SetSelectedState("normal")

				arg_629_1.keyicon_.color = Color.New(1, 1, 1)
				arg_629_1.icon_.color = Color.New(1, 1, 1)

				local var_632_1 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(1105006150).content)

				arg_629_1.text_.text = var_632_1

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_3 = 12 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 12)

				if (12 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 12)) > 0 and var_632_0 < var_632_3 then
					arg_629_1.talkMaxDuration = var_632_3

					if var_632_3 + 0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_3 + 0
					end
				end

				arg_629_1.text_.text = var_632_1
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_4 = math.max(var_632_0, arg_629_1.talkMaxDuration)

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_4 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - 0) / var_632_4

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= 0 + var_632_4 and arg_629_1.time_ < 0 + var_632_4 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1105006151 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1105006151
		arg_633_1.duration_ = 11.8

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1105006152(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = 1

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_1 = arg_633_1:GetWordFromCfg(1105006151)
				local var_636_2 = arg_633_1:FormatText(var_636_1.content)

				arg_633_1.text_.text = var_636_2

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_4 = 40 <= 0 and var_636_0 or var_636_0 * (utf8.len(var_636_2) / 40)

				if (40 <= 0 and var_636_0 or var_636_0 * (utf8.len(var_636_2) / 40)) > 0 and var_636_0 < var_636_4 then
					arg_633_1.talkMaxDuration = var_636_4

					if var_636_4 + 0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_4 + 0
					end
				end

				arg_633_1.text_.text = var_636_2
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb") ~= 0 then
					local var_636_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb") / 1000

					if var_636_5 + 0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_5 + 0
					end

					if var_636_1.prefab_name ~= "" and arg_633_1.actors_[var_636_1.prefab_name] ~= nil then
						local var_636_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_1.prefab_name].transform, "story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb")

						arg_633_1:RecordAudio("1105006151", var_636_6)
						arg_633_1:RecordAudio("1105006151", var_636_6)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006151", "story_v_side_new_1105006.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_7 = math.max(var_636_0, arg_633_1.talkMaxDuration)

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_7 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - 0) / var_636_7

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= 0 + var_636_7 and arg_633_1.time_ < 0 + var_636_7 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play1105006152 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1105006152
		arg_637_1.duration_ = 7.23

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1105006153(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0.55

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_1 = arg_637_1:GetWordFromCfg(1105006152)
				local var_640_2 = arg_637_1:FormatText(var_640_1.content)

				arg_637_1.text_.text = var_640_2

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_4 = 22 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 22)

				if (22 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 22)) > 0 and var_640_0 < var_640_4 then
					arg_637_1.talkMaxDuration = var_640_4

					if var_640_4 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_4 + 0
					end
				end

				arg_637_1.text_.text = var_640_2
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb") ~= 0 then
					local var_640_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb") / 1000

					if var_640_5 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_5 + 0
					end

					if var_640_1.prefab_name ~= "" and arg_637_1.actors_[var_640_1.prefab_name] ~= nil then
						local var_640_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_1.prefab_name].transform, "story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb")

						arg_637_1:RecordAudio("1105006152", var_640_6)
						arg_637_1:RecordAudio("1105006152", var_640_6)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006152", "story_v_side_new_1105006.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_7 = math.max(var_640_0, arg_637_1.talkMaxDuration)

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_7 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - 0) / var_640_7

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= 0 + var_640_7 and arg_637_1.time_ < 0 + var_640_7 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1105006153 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1105006153
		arg_641_1.duration_ = 4.37

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1105006154(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0.625

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_1 = arg_641_1:GetWordFromCfg(1105006153)
				local var_644_2 = arg_641_1:FormatText(var_644_1.content)

				arg_641_1.text_.text = var_644_2

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_4 = 25 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_2) / 25)

				if (25 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_2) / 25)) > 0 and var_644_0 < var_644_4 then
					arg_641_1.talkMaxDuration = var_644_4

					if var_644_4 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_4 + 0
					end
				end

				arg_641_1.text_.text = var_644_2
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb") ~= 0 then
					local var_644_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb") / 1000

					if var_644_5 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_5 + 0
					end

					if var_644_1.prefab_name ~= "" and arg_641_1.actors_[var_644_1.prefab_name] ~= nil then
						local var_644_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_1.prefab_name].transform, "story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb")

						arg_641_1:RecordAudio("1105006153", var_644_6)
						arg_641_1:RecordAudio("1105006153", var_644_6)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006153", "story_v_side_new_1105006.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_7 = math.max(var_644_0, arg_641_1.talkMaxDuration)

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_7 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - 0) / var_644_7

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= 0 + var_644_7 and arg_641_1.time_ < 0 + var_644_7 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1105006154 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1105006154
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1105006155(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0.175

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_1 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(1105006154).content)

				arg_645_1.text_.text = var_648_1

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_3 = 7 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 7)

				if (7 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 7)) > 0 and var_648_0 < var_648_3 then
					arg_645_1.talkMaxDuration = var_648_3

					if var_648_3 + 0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_3 + 0
					end
				end

				arg_645_1.text_.text = var_648_1
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_4 = math.max(var_648_0, arg_645_1.talkMaxDuration)

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_4 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - 0) / var_648_4

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= 0 + var_648_4 and arg_645_1.time_ < 0 + var_648_4 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1105006155 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1105006155
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1105006156(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.45

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, true)
				arg_649_1.iconController_:SetSelectedState("hero")

				arg_649_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_649_1.callingController_:SetSelectedState("normal")

				arg_649_1.keyicon_.color = Color.New(1, 1, 1)
				arg_649_1.icon_.color = Color.New(1, 1, 1)

				local var_652_1 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(1105006155).content)

				arg_649_1.text_.text = var_652_1

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_3 = 18 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 18)

				if (18 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 18)) > 0 and var_652_0 < var_652_3 then
					arg_649_1.talkMaxDuration = var_652_3

					if var_652_3 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_3 + 0
					end
				end

				arg_649_1.text_.text = var_652_1
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_4 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_4

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1105006156 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1105006156
		arg_653_1.duration_ = 7

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1105006157(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				local var_656_0 = arg_653_1.bgs_.R5002a

				arg_653_1.bgs_.R5002a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_656_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_656_1 = var_656_0:GetComponent("SpriteRenderer")

				if var_656_1 and var_656_1.sprite then
					local var_656_2 = 2 * (var_656_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_656_0.transform.localScale = Vector3.New(var_656_2 / var_656_1.sprite.bounds.size.y < var_656_2 * manager.ui.mainCameraCom_.aspect / var_656_1.sprite.bounds.size.x and var_656_2 * manager.ui.mainCameraCom_.aspect / var_656_1.sprite.bounds.size.x or var_656_2 / var_656_1.sprite.bounds.size.y, var_656_2 / var_656_1.sprite.bounds.size.y < var_656_2 * manager.ui.mainCameraCom_.aspect / var_656_1.sprite.bounds.size.x and var_656_2 * manager.ui.mainCameraCom_.aspect / var_656_1.sprite.bounds.size.x or var_656_2 / var_656_1.sprite.bounds.size.y, 0)
				end

				for iter_656_0, iter_656_1 in pairs(arg_653_1.bgs_) do
					if iter_656_0 ~= "R5002a" then
						iter_656_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_656_3 = 0

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_3 + arg_656_0 then
				arg_653_1.mask_.enabled = true
				arg_653_1.mask_.raycastTarget = true

				arg_653_1:SetGaussion(false)
			end

			local var_656_4 = 2

			if var_656_3 <= arg_653_1.time_ and arg_653_1.time_ < var_656_3 + var_656_4 then
				local var_656_5 = Color.New(0, 0, 0)

				var_656_5.a = Mathf.Lerp(1, 0, (arg_653_1.time_ - var_656_3) / var_656_4)
				arg_653_1.mask_.color = var_656_5
			end

			if arg_653_1.time_ >= var_656_3 + var_656_4 and arg_653_1.time_ < var_656_3 + var_656_4 + arg_656_0 then
				local var_656_6 = Color.New(0, 0, 0)

				arg_653_1.mask_.enabled = false
				var_656_6.a = 0
				arg_653_1.mask_.color = var_656_6
			end

			if arg_653_1.frameCnt_ <= 1 then
				arg_653_1.dialog_:SetActive(false)
			end

			local var_656_7 = 2
			local var_656_8 = 0.95

			if 2 < arg_653_1.time_ and arg_653_1.time_ <= var_656_7 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0

				arg_653_1.dialog_:SetActive(true)

				arg_653_1.dialogCg_.alpha = 0

				local var_656_9 = LeanTween.value(arg_653_1.dialog_, 0, 1, 0.3)

				var_656_9:setOnUpdate(LuaHelper.FloatAction(function(arg_657_0)
					arg_653_1.dialogCg_.alpha = arg_657_0
				end))
				var_656_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_653_1.dialog_)
					var_656_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_653_1.duration_ = arg_653_1.duration_ + 0.3

				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_10 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(1105006156).content)

				arg_653_1.text_.text = var_656_10

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_12 = 38 <= 0 and var_656_8 or var_656_8 * (utf8.len(var_656_10) / 38)

				if (38 <= 0 and var_656_8 or var_656_8 * (utf8.len(var_656_10) / 38)) > 0 and var_656_8 < var_656_12 then
					arg_653_1.talkMaxDuration = var_656_12
					var_656_7 = var_656_7 + 0.3

					if var_656_12 + var_656_7 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_12 + var_656_7
					end
				end

				arg_653_1.text_.text = var_656_10
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_13 = var_656_7 + 0.3
			local var_656_14 = math.max(var_656_8, arg_653_1.talkMaxDuration)

			if var_656_7 + 0.3 <= arg_653_1.time_ and arg_653_1.time_ < var_656_13 + var_656_14 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_13) / var_656_14

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_13 + var_656_14 and arg_653_1.time_ < var_656_13 + var_656_14 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1105006157 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1105006157
		arg_659_1.duration_ = 3.8

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1105006158(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0.3

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_1 = arg_659_1:GetWordFromCfg(1105006157)
				local var_662_2 = arg_659_1:FormatText(var_662_1.content)

				arg_659_1.text_.text = var_662_2

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_4 = 12 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_2) / 12)

				if (12 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_2) / 12)) > 0 and var_662_0 < var_662_4 then
					arg_659_1.talkMaxDuration = var_662_4

					if var_662_4 + 0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_4 + 0
					end
				end

				arg_659_1.text_.text = var_662_2
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb") ~= 0 then
					local var_662_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb") / 1000

					if var_662_5 + 0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_5 + 0
					end

					if var_662_1.prefab_name ~= "" and arg_659_1.actors_[var_662_1.prefab_name] ~= nil then
						local var_662_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_1.prefab_name].transform, "story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb")

						arg_659_1:RecordAudio("1105006157", var_662_6)
						arg_659_1:RecordAudio("1105006157", var_662_6)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006157", "story_v_side_new_1105006.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_7 = math.max(var_662_0, arg_659_1.talkMaxDuration)

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_7 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - 0) / var_662_7

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= 0 + var_662_7 and arg_659_1.time_ < 0 + var_662_7 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1105006158 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1105006158
		arg_663_1.duration_ = 7

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1105006159(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 2 < arg_663_1.time_ and arg_663_1.time_ <= 2 + arg_666_0 then
				arg_663_1.allBtn_.enabled = false
			end

			if arg_663_1.time_ >= 2 + 0.3 and arg_663_1.time_ < 2 + 0.3 + arg_666_0 then
				arg_663_1.allBtn_.enabled = true
			end

			if 1 < arg_663_1.time_ and arg_663_1.time_ <= 1 + arg_666_0 then
				local var_666_0 = arg_663_1.bgs_.STblack

				arg_663_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_666_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_666_1 = var_666_0:GetComponent("SpriteRenderer")

				if var_666_1 and var_666_1.sprite then
					local var_666_2 = 2 * (var_666_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_666_0.transform.localScale = Vector3.New(var_666_2 / var_666_1.sprite.bounds.size.y < var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x and var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x or var_666_2 / var_666_1.sprite.bounds.size.y, var_666_2 / var_666_1.sprite.bounds.size.y < var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x and var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x or var_666_2 / var_666_1.sprite.bounds.size.y, 0)
				end

				for iter_666_0, iter_666_1 in pairs(arg_663_1.bgs_) do
					if iter_666_0 ~= "STblack" then
						iter_666_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_666_3 = 0

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_3 + arg_666_0 then
				arg_663_1.mask_.enabled = true
				arg_663_1.mask_.raycastTarget = true

				arg_663_1:SetGaussion(false)
			end

			local var_666_4 = 1

			if var_666_3 <= arg_663_1.time_ and arg_663_1.time_ < var_666_3 + var_666_4 then
				local var_666_5 = Color.New(0, 0, 0)

				var_666_5.a = Mathf.Lerp(0, 1, (arg_663_1.time_ - var_666_3) / var_666_4)
				arg_663_1.mask_.color = var_666_5
			end

			if arg_663_1.time_ >= var_666_3 + var_666_4 and arg_663_1.time_ < var_666_3 + var_666_4 + arg_666_0 then
				local var_666_6 = Color.New(0, 0, 0)

				var_666_6.a = 1
				arg_663_1.mask_.color = var_666_6
			end

			local var_666_7 = 1

			if 1 < arg_663_1.time_ and arg_663_1.time_ <= var_666_7 + arg_666_0 then
				arg_663_1.mask_.enabled = true
				arg_663_1.mask_.raycastTarget = true

				arg_663_1:SetGaussion(false)
			end

			local var_666_8 = 1

			if var_666_7 <= arg_663_1.time_ and arg_663_1.time_ < var_666_7 + var_666_8 then
				local var_666_9 = Color.New(0, 0, 0)

				var_666_9.a = Mathf.Lerp(1, 0, (arg_663_1.time_ - var_666_7) / var_666_8)
				arg_663_1.mask_.color = var_666_9
			end

			if arg_663_1.time_ >= var_666_7 + var_666_8 and arg_663_1.time_ < var_666_7 + var_666_8 + arg_666_0 then
				local var_666_10 = Color.New(0, 0, 0)

				arg_663_1.mask_.enabled = false
				var_666_10.a = 0
				arg_663_1.mask_.color = var_666_10
			end

			if arg_663_1.frameCnt_ <= 1 then
				arg_663_1.dialog_:SetActive(false)
			end

			local var_666_11 = 2
			local var_666_12 = 0.775

			if 2 < arg_663_1.time_ and arg_663_1.time_ <= var_666_11 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0

				arg_663_1.dialog_:SetActive(true)

				arg_663_1.dialogCg_.alpha = 0

				local var_666_13 = LeanTween.value(arg_663_1.dialog_, 0, 1, 0.3)

				var_666_13:setOnUpdate(LuaHelper.FloatAction(function(arg_667_0)
					arg_663_1.dialogCg_.alpha = arg_667_0
				end))
				var_666_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_663_1.dialog_)
					var_666_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_663_1.duration_ = arg_663_1.duration_ + 0.3

				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_14 = arg_663_1:FormatText(arg_663_1:GetWordFromCfg(1105006158).content)

				arg_663_1.text_.text = var_666_14

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_16 = 31 <= 0 and var_666_12 or var_666_12 * (utf8.len(var_666_14) / 31)

				if (31 <= 0 and var_666_12 or var_666_12 * (utf8.len(var_666_14) / 31)) > 0 and var_666_12 < var_666_16 then
					arg_663_1.talkMaxDuration = var_666_16
					var_666_11 = var_666_11 + 0.3

					if var_666_16 + var_666_11 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_16 + var_666_11
					end
				end

				arg_663_1.text_.text = var_666_14
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_17 = var_666_11 + 0.3
			local var_666_18 = math.max(var_666_12, arg_663_1.talkMaxDuration)

			if var_666_11 + 0.3 <= arg_663_1.time_ and arg_663_1.time_ < var_666_17 + var_666_18 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_17) / var_666_18

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_17 + var_666_18 and arg_663_1.time_ < var_666_17 + var_666_18 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play1105006159 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1105006159
		arg_669_1.duration_ = 10.07

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1105006160(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 1.03333333333333 < arg_669_1.time_ and arg_669_1.time_ <= 1.03333333333333 + arg_672_0 then
				local var_672_0 = arg_669_1.bgs_.ST16

				arg_669_1.bgs_.ST16.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_672_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_672_1 = var_672_0:GetComponent("SpriteRenderer")

				if var_672_1 and var_672_1.sprite then
					local var_672_2 = 2 * (var_672_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_672_0.transform.localScale = Vector3.New(var_672_2 / var_672_1.sprite.bounds.size.y < var_672_2 * manager.ui.mainCameraCom_.aspect / var_672_1.sprite.bounds.size.x and var_672_2 * manager.ui.mainCameraCom_.aspect / var_672_1.sprite.bounds.size.x or var_672_2 / var_672_1.sprite.bounds.size.y, var_672_2 / var_672_1.sprite.bounds.size.y < var_672_2 * manager.ui.mainCameraCom_.aspect / var_672_1.sprite.bounds.size.x and var_672_2 * manager.ui.mainCameraCom_.aspect / var_672_1.sprite.bounds.size.x or var_672_2 / var_672_1.sprite.bounds.size.y, 0)
				end

				for iter_672_0, iter_672_1 in pairs(arg_669_1.bgs_) do
					if iter_672_0 ~= "ST16" then
						iter_672_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_672_3 = 2.06666666666667

			if 2.06666666666667 < arg_669_1.time_ and arg_669_1.time_ <= var_672_3 + arg_672_0 then
				arg_669_1.allBtn_.enabled = false
			end

			if arg_669_1.time_ >= var_672_3 + 0.3 and arg_669_1.time_ < var_672_3 + 0.3 + arg_672_0 then
				arg_669_1.allBtn_.enabled = true
			end

			local var_672_4 = 0

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_4 + arg_672_0 then
				arg_669_1.mask_.enabled = true
				arg_669_1.mask_.raycastTarget = true

				arg_669_1:SetGaussion(false)
			end

			local var_672_5 = 1.03333333333333

			if var_672_4 <= arg_669_1.time_ and arg_669_1.time_ < var_672_4 + var_672_5 then
				local var_672_6 = Color.New(0, 0, 0)

				var_672_6.a = Mathf.Lerp(0, 1, (arg_669_1.time_ - var_672_4) / var_672_5)
				arg_669_1.mask_.color = var_672_6
			end

			if arg_669_1.time_ >= var_672_4 + var_672_5 and arg_669_1.time_ < var_672_4 + var_672_5 + arg_672_0 then
				local var_672_7 = Color.New(0, 0, 0)

				var_672_7.a = 1
				arg_669_1.mask_.color = var_672_7
			end

			local var_672_8 = 1.03333333333333

			if 1.03333333333333 < arg_669_1.time_ and arg_669_1.time_ <= var_672_8 + arg_672_0 then
				arg_669_1.mask_.enabled = true
				arg_669_1.mask_.raycastTarget = true

				arg_669_1:SetGaussion(false)
			end

			local var_672_9 = 1.03333333333333

			if var_672_8 <= arg_669_1.time_ and arg_669_1.time_ < var_672_8 + var_672_9 then
				local var_672_10 = Color.New(0, 0, 0)

				var_672_10.a = Mathf.Lerp(1, 0, (arg_669_1.time_ - var_672_8) / var_672_9)
				arg_669_1.mask_.color = var_672_10
			end

			if arg_669_1.time_ >= var_672_8 + var_672_9 and arg_669_1.time_ < var_672_8 + var_672_9 + arg_672_0 then
				local var_672_11 = Color.New(0, 0, 0)

				arg_669_1.mask_.enabled = false
				var_672_11.a = 0
				arg_669_1.mask_.color = var_672_11
			end

			if arg_669_1.frameCnt_ <= 1 then
				arg_669_1.dialog_:SetActive(false)
			end

			local var_672_12 = 2.06666666666667
			local var_672_13 = 1.075

			if 2.06666666666667 < arg_669_1.time_ and arg_669_1.time_ <= var_672_12 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0

				arg_669_1.dialog_:SetActive(true)

				arg_669_1.dialogCg_.alpha = 0

				local var_672_14 = LeanTween.value(arg_669_1.dialog_, 0, 1, 0.3)

				var_672_14:setOnUpdate(LuaHelper.FloatAction(function(arg_673_0)
					arg_669_1.dialogCg_.alpha = arg_673_0
				end))
				var_672_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_669_1.dialog_)
					var_672_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_669_1.duration_ = arg_669_1.duration_ + 0.3

				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[224].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_15 = arg_669_1:GetWordFromCfg(1105006159)
				local var_672_16 = arg_669_1:FormatText(var_672_15.content)

				arg_669_1.text_.text = var_672_16

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_18 = 43 <= 0 and var_672_13 or var_672_13 * (utf8.len(var_672_16) / 43)

				if (43 <= 0 and var_672_13 or var_672_13 * (utf8.len(var_672_16) / 43)) > 0 and var_672_13 < var_672_18 then
					arg_669_1.talkMaxDuration = var_672_18
					var_672_12 = var_672_12 + 0.3

					if var_672_18 + var_672_12 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_18 + var_672_12
					end
				end

				arg_669_1.text_.text = var_672_16
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb") ~= 0 then
					local var_672_19 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb") / 1000

					if var_672_19 + var_672_12 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_19 + var_672_12
					end

					if var_672_15.prefab_name ~= "" and arg_669_1.actors_[var_672_15.prefab_name] ~= nil then
						local var_672_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_15.prefab_name].transform, "story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb")

						arg_669_1:RecordAudio("1105006159", var_672_20)
						arg_669_1:RecordAudio("1105006159", var_672_20)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006159", "story_v_side_new_1105006.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_21 = var_672_12 + 0.3
			local var_672_22 = math.max(var_672_13, arg_669_1.talkMaxDuration)

			if var_672_12 + 0.3 <= arg_669_1.time_ and arg_669_1.time_ < var_672_21 + var_672_22 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_21) / var_672_22

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_21 + var_672_22 and arg_669_1.time_ < var_672_21 + var_672_22 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1105006160 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1105006160
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1105006161(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0.85

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, false)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_1 = arg_675_1:FormatText(arg_675_1:GetWordFromCfg(1105006160).content)

				arg_675_1.text_.text = var_678_1

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_3 = 34 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_1) / 34)

				if (34 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_1) / 34)) > 0 and var_678_0 < var_678_3 then
					arg_675_1.talkMaxDuration = var_678_3

					if var_678_3 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_3 + 0
					end
				end

				arg_675_1.text_.text = var_678_1
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_4 = math.max(var_678_0, arg_675_1.talkMaxDuration)

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_4 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - 0) / var_678_4

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= 0 + var_678_4 and arg_675_1.time_ < 0 + var_678_4 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play1105006161 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1105006161
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1105006162(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 1.2

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_1 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(1105006161).content)

				arg_679_1.text_.text = var_682_1

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_3 = 48 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 48)

				if (48 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 48)) > 0 and var_682_0 < var_682_3 then
					arg_679_1.talkMaxDuration = var_682_3

					if var_682_3 + 0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_3 + 0
					end
				end

				arg_679_1.text_.text = var_682_1
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_4 = math.max(var_682_0, arg_679_1.talkMaxDuration)

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_4 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - 0) / var_682_4

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= 0 + var_682_4 and arg_679_1.time_ < 0 + var_682_4 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1105006162 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1105006162
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1105006163(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0.9

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_1 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(1105006162).content)

				arg_683_1.text_.text = var_686_1

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_3 = 36 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 36)

				if (36 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 36)) > 0 and var_686_0 < var_686_3 then
					arg_683_1.talkMaxDuration = var_686_3

					if var_686_3 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_3 + 0
					end
				end

				arg_683_1.text_.text = var_686_1
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_4 = math.max(var_686_0, arg_683_1.talkMaxDuration)

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_4 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - 0) / var_686_4

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= 0 + var_686_4 and arg_683_1.time_ < 0 + var_686_4 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1105006163 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1105006163
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1105006164(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 1.35

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, false)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_1 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(1105006163).content)

				arg_687_1.text_.text = var_690_1

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_3 = 54 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 54)

				if (54 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 54)) > 0 and var_690_0 < var_690_3 then
					arg_687_1.talkMaxDuration = var_690_3

					if var_690_3 + 0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_3 + 0
					end
				end

				arg_687_1.text_.text = var_690_1
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_4 = math.max(var_690_0, arg_687_1.talkMaxDuration)

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_4 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - 0) / var_690_4

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= 0 + var_690_4 and arg_687_1.time_ < 0 + var_690_4 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1105006164 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1105006164
		arg_691_1.duration_ = 5.6

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1105006165(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if arg_691_1.actors_["1150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1150ui_story"))) then
				local var_694_0 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_691_1.stage_.transform)

				var_694_0.name = "1150ui_story"
				var_694_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_691_1.actors_["1150ui_story"] = var_694_0

				local var_694_1 = var_694_0:GetComponentInChildren(typeof(CharacterEffect))

				var_694_1.enabled = true

				local var_694_2 = GameObjectTools.GetOrAddComponent(var_694_0, typeof(DynamicBoneHelper))

				if var_694_2 then
					var_694_2:EnableDynamicBone(false)
				end

				arg_691_1:ShowWeapon(var_694_1.transform, false)

				arg_691_1.var_["1150ui_story" .. "Animator"] = var_694_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_691_1.var_["1150ui_story" .. "Animator"].applyRootMotion = true
				arg_691_1.var_["1150ui_story" .. "LipSync"] = var_694_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_694_3 = arg_691_1.actors_["1150ui_story"].transform

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1.var_.moveOldPos1150ui_story = var_694_3.localPosition
			end

			local var_694_4 = 0.001

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_4 then
				var_694_3.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_691_1.time_ - 0) / var_694_4)
				var_694_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_694_3.position).x, (manager.ui.mainCamera.transform.position - var_694_3.position).y, (manager.ui.mainCamera.transform.position - var_694_3.position).z)
				var_694_3.localEulerAngles.z = 0
				var_694_3.localEulerAngles.x = 0
				var_694_3.localEulerAngles = var_694_3.localEulerAngles
			end

			if arg_691_1.time_ >= 0 + var_694_4 and arg_691_1.time_ < 0 + var_694_4 + arg_694_0 then
				var_694_3.localPosition = Vector3.New(0, -1.01, -6.2)
				var_694_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_694_3.position).x, (manager.ui.mainCamera.transform.position - var_694_3.position).y, (manager.ui.mainCamera.transform.position - var_694_3.position).z)
				var_694_3.localEulerAngles.z = 0
				var_694_3.localEulerAngles.x = 0
				var_694_3.localEulerAngles = var_694_3.localEulerAngles
			end

			local var_694_5 = arg_691_1.actors_["1150ui_story"]

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(var_694_5) and arg_691_1.var_.characterEffect1150ui_story == nil then
				arg_691_1.var_.characterEffect1150ui_story = var_694_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_6 = 0.200000002980232

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_6 and not isNil(var_694_5) then
				if arg_691_1.var_.characterEffect1150ui_story and not isNil(var_694_5) then
					arg_691_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= 0 + var_694_6 and arg_691_1.time_ < 0 + var_694_6 + arg_694_0 and not isNil(var_694_5) and arg_691_1.var_.characterEffect1150ui_story then
				arg_691_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_694_8 = 0
			local var_694_9 = 0.525

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_8 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_10 = arg_691_1:GetWordFromCfg(1105006164)
				local var_694_11 = arg_691_1:FormatText(var_694_10.content)

				arg_691_1.text_.text = var_694_11

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_13 = 21 <= 0 and var_694_9 or var_694_9 * (utf8.len(var_694_11) / 21)

				if (21 <= 0 and var_694_9 or var_694_9 * (utf8.len(var_694_11) / 21)) > 0 and var_694_9 < var_694_13 then
					arg_691_1.talkMaxDuration = var_694_13

					if var_694_13 + var_694_8 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_13 + var_694_8
					end
				end

				arg_691_1.text_.text = var_694_11
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb") ~= 0 then
					local var_694_14 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb") / 1000

					if var_694_14 + var_694_8 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_14 + var_694_8
					end

					if var_694_10.prefab_name ~= "" and arg_691_1.actors_[var_694_10.prefab_name] ~= nil then
						local var_694_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_10.prefab_name].transform, "story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb")

						arg_691_1:RecordAudio("1105006164", var_694_15)
						arg_691_1:RecordAudio("1105006164", var_694_15)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006164", "story_v_side_new_1105006.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_16 = math.max(var_694_9, arg_691_1.talkMaxDuration)

			if var_694_8 <= arg_691_1.time_ and arg_691_1.time_ < var_694_8 + var_694_16 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_8) / var_694_16

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_8 + var_694_16 and arg_691_1.time_ < var_694_8 + var_694_16 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_691_1:InitPlayNodeList()
	end,
	Play1105006165 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1105006165
		arg_695_1.duration_ = 4.37

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1105006166(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0.4

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_1 = arg_695_1:GetWordFromCfg(1105006165)
				local var_698_2 = arg_695_1:FormatText(var_698_1.content)

				arg_695_1.text_.text = var_698_2

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_4 = 16 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_2) / 16)

				if (16 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_2) / 16)) > 0 and var_698_0 < var_698_4 then
					arg_695_1.talkMaxDuration = var_698_4

					if var_698_4 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_4 + 0
					end
				end

				arg_695_1.text_.text = var_698_2
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb") ~= 0 then
					local var_698_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb") / 1000

					if var_698_5 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_5 + 0
					end

					if var_698_1.prefab_name ~= "" and arg_695_1.actors_[var_698_1.prefab_name] ~= nil then
						local var_698_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_1.prefab_name].transform, "story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb")

						arg_695_1:RecordAudio("1105006165", var_698_6)
						arg_695_1:RecordAudio("1105006165", var_698_6)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006165", "story_v_side_new_1105006.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_7 = math.max(var_698_0, arg_695_1.talkMaxDuration)

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_7 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - 0) / var_698_7

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= 0 + var_698_7 and arg_695_1.time_ < 0 + var_698_7 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1105006166 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1105006166
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1105006167(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.var_.moveOldPos1150ui_story = arg_699_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_702_0 = 0.001

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 then
				arg_699_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_699_1.time_ - 0) / var_702_0)
				arg_699_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1150ui_story"].transform.position).z)
				arg_699_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["1150ui_story"].transform.localEulerAngles = arg_699_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 then
				arg_699_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_699_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1150ui_story"].transform.position).z)
				arg_699_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["1150ui_story"].transform.localEulerAngles = arg_699_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_702_1 = 0
			local var_702_2 = 1.1

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, false)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_3 = arg_699_1:FormatText(arg_699_1:GetWordFromCfg(1105006166).content)

				arg_699_1.text_.text = var_702_3

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_5 = 44 <= 0 and var_702_2 or var_702_2 * (utf8.len(var_702_3) / 44)

				if (44 <= 0 and var_702_2 or var_702_2 * (utf8.len(var_702_3) / 44)) > 0 and var_702_2 < var_702_5 then
					arg_699_1.talkMaxDuration = var_702_5

					if var_702_5 + var_702_1 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_5 + var_702_1
					end
				end

				arg_699_1.text_.text = var_702_3
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_6 = math.max(var_702_2, arg_699_1.talkMaxDuration)

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_6 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_1) / var_702_6

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_1 + var_702_6 and arg_699_1.time_ < var_702_1 + var_702_6 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play1105006167 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1105006167
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1105006168(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = 1.475

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_1 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(1105006167).content)

				arg_703_1.text_.text = var_706_1

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_3 = 59 <= 0 and var_706_0 or var_706_0 * (utf8.len(var_706_1) / 59)

				if (59 <= 0 and var_706_0 or var_706_0 * (utf8.len(var_706_1) / 59)) > 0 and var_706_0 < var_706_3 then
					arg_703_1.talkMaxDuration = var_706_3

					if var_706_3 + 0 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_3 + 0
					end
				end

				arg_703_1.text_.text = var_706_1
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_4 = math.max(var_706_0, arg_703_1.talkMaxDuration)

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_4 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - 0) / var_706_4

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= 0 + var_706_4 and arg_703_1.time_ < 0 + var_706_4 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play1105006168 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1105006168
		arg_707_1.duration_ = 3.6

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1105006169(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.var_.moveOldPos1150ui_story = arg_707_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_710_0 = 0.001

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_0 then
				arg_707_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_707_1.time_ - 0) / var_710_0)
				arg_707_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1150ui_story"].transform.position).z)
				arg_707_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["1150ui_story"].transform.localEulerAngles = arg_707_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_707_1.time_ >= 0 + var_710_0 and arg_707_1.time_ < 0 + var_710_0 + arg_710_0 then
				arg_707_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_707_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1150ui_story"].transform.position).z)
				arg_707_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["1150ui_story"].transform.localEulerAngles = arg_707_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_710_1 = arg_707_1.actors_["1150ui_story"]

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 and not isNil(var_710_1) and arg_707_1.var_.characterEffect1150ui_story == nil then
				arg_707_1.var_.characterEffect1150ui_story = var_710_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_2 = 0.200000002980232

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_2 and not isNil(var_710_1) then
				if arg_707_1.var_.characterEffect1150ui_story and not isNil(var_710_1) then
					arg_707_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_707_1.time_ >= 0 + var_710_2 and arg_707_1.time_ < 0 + var_710_2 + arg_710_0 and not isNil(var_710_1) and arg_707_1.var_.characterEffect1150ui_story then
				arg_707_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_710_4 = 0
			local var_710_5 = 0.3

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_4 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_6 = arg_707_1:GetWordFromCfg(1105006168)
				local var_710_7 = arg_707_1:FormatText(var_710_6.content)

				arg_707_1.text_.text = var_710_7

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_9 = 12 <= 0 and var_710_5 or var_710_5 * (utf8.len(var_710_7) / 12)

				if (12 <= 0 and var_710_5 or var_710_5 * (utf8.len(var_710_7) / 12)) > 0 and var_710_5 < var_710_9 then
					arg_707_1.talkMaxDuration = var_710_9

					if var_710_9 + var_710_4 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_9 + var_710_4
					end
				end

				arg_707_1.text_.text = var_710_7
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb") ~= 0 then
					local var_710_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb") / 1000

					if var_710_10 + var_710_4 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_10 + var_710_4
					end

					if var_710_6.prefab_name ~= "" and arg_707_1.actors_[var_710_6.prefab_name] ~= nil then
						local var_710_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_6.prefab_name].transform, "story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb")

						arg_707_1:RecordAudio("1105006168", var_710_11)
						arg_707_1:RecordAudio("1105006168", var_710_11)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006168", "story_v_side_new_1105006.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_12 = math.max(var_710_5, arg_707_1.talkMaxDuration)

			if var_710_4 <= arg_707_1.time_ and arg_707_1.time_ < var_710_4 + var_710_12 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_4) / var_710_12

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_4 + var_710_12 and arg_707_1.time_ < var_710_4 + var_710_12 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play1105006169 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1105006169
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1105006170(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 and not isNil(arg_711_1.actors_["1150ui_story"]) and arg_711_1.var_.characterEffect1150ui_story == nil then
				arg_711_1.var_.characterEffect1150ui_story = arg_711_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_0 = 0.200000002980232

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_0 and not isNil(arg_711_1.actors_["1150ui_story"]) then
				if arg_711_1.var_.characterEffect1150ui_story and not isNil(arg_711_1.actors_["1150ui_story"]) then
					arg_711_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_711_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_711_1.time_ - 0) / var_714_0)
				end
			end

			if arg_711_1.time_ >= 0 + var_714_0 and arg_711_1.time_ < 0 + var_714_0 + arg_714_0 and not isNil(arg_711_1.actors_["1150ui_story"]) and arg_711_1.var_.characterEffect1150ui_story then
				arg_711_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_711_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_714_1 = 0
			local var_714_2 = 0.875

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, false)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_3 = arg_711_1:FormatText(arg_711_1:GetWordFromCfg(1105006169).content)

				arg_711_1.text_.text = var_714_3

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_5 = 35 <= 0 and var_714_2 or var_714_2 * (utf8.len(var_714_3) / 35)

				if (35 <= 0 and var_714_2 or var_714_2 * (utf8.len(var_714_3) / 35)) > 0 and var_714_2 < var_714_5 then
					arg_711_1.talkMaxDuration = var_714_5

					if var_714_5 + var_714_1 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_5 + var_714_1
					end
				end

				arg_711_1.text_.text = var_714_3
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_6 = math.max(var_714_2, arg_711_1.talkMaxDuration)

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_6 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_1) / var_714_6

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_1 + var_714_6 and arg_711_1.time_ < var_714_1 + var_714_6 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play1105006170 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1105006170
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1105006171(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 1.025

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, false)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_1 = arg_715_1:FormatText(arg_715_1:GetWordFromCfg(1105006170).content)

				arg_715_1.text_.text = var_718_1

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_3 = 41 <= 0 and var_718_0 or var_718_0 * (utf8.len(var_718_1) / 41)

				if (41 <= 0 and var_718_0 or var_718_0 * (utf8.len(var_718_1) / 41)) > 0 and var_718_0 < var_718_3 then
					arg_715_1.talkMaxDuration = var_718_3

					if var_718_3 + 0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_3 + 0
					end
				end

				arg_715_1.text_.text = var_718_1
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_4 = math.max(var_718_0, arg_715_1.talkMaxDuration)

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_4 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - 0) / var_718_4

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= 0 + var_718_4 and arg_715_1.time_ < 0 + var_718_4 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play1105006171 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 1105006171
		arg_719_1.duration_ = 12.27

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play1105006172(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 and not isNil(arg_719_1.actors_["1150ui_story"]) and arg_719_1.var_.characterEffect1150ui_story == nil then
				arg_719_1.var_.characterEffect1150ui_story = arg_719_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_0 = 0.200000002980232

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_0 and not isNil(arg_719_1.actors_["1150ui_story"]) then
				if arg_719_1.var_.characterEffect1150ui_story and not isNil(arg_719_1.actors_["1150ui_story"]) then
					arg_719_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_719_1.time_ >= 0 + var_722_0 and arg_719_1.time_ < 0 + var_722_0 + arg_722_0 and not isNil(arg_719_1.actors_["1150ui_story"]) and arg_719_1.var_.characterEffect1150ui_story then
				arg_719_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_722_2 = 0
			local var_722_3 = 1.175

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_2 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_4 = arg_719_1:GetWordFromCfg(1105006171)
				local var_722_5 = arg_719_1:FormatText(var_722_4.content)

				arg_719_1.text_.text = var_722_5

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_7 = 48 <= 0 and var_722_3 or var_722_3 * (utf8.len(var_722_5) / 48)

				if (48 <= 0 and var_722_3 or var_722_3 * (utf8.len(var_722_5) / 48)) > 0 and var_722_3 < var_722_7 then
					arg_719_1.talkMaxDuration = var_722_7

					if var_722_7 + var_722_2 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_7 + var_722_2
					end
				end

				arg_719_1.text_.text = var_722_5
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb") ~= 0 then
					local var_722_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb") / 1000

					if var_722_8 + var_722_2 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_8 + var_722_2
					end

					if var_722_4.prefab_name ~= "" and arg_719_1.actors_[var_722_4.prefab_name] ~= nil then
						local var_722_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_4.prefab_name].transform, "story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb")

						arg_719_1:RecordAudio("1105006171", var_722_9)
						arg_719_1:RecordAudio("1105006171", var_722_9)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006171", "story_v_side_new_1105006.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_10 = math.max(var_722_3, arg_719_1.talkMaxDuration)

			if var_722_2 <= arg_719_1.time_ and arg_719_1.time_ < var_722_2 + var_722_10 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_2) / var_722_10

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_2 + var_722_10 and arg_719_1.time_ < var_722_2 + var_722_10 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play1105006172 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 1105006172
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play1105006173(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1.var_.moveOldPos1150ui_story = arg_723_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_726_0 = 0.001

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_0 then
				arg_723_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_723_1.time_ - 0) / var_726_0)
				arg_723_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_723_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1150ui_story"].transform.position).z)
				arg_723_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_723_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_723_1.actors_["1150ui_story"].transform.localEulerAngles = arg_723_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_723_1.time_ >= 0 + var_726_0 and arg_723_1.time_ < 0 + var_726_0 + arg_726_0 then
				arg_723_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_723_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_723_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1150ui_story"].transform.position).z)
				arg_723_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_723_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_723_1.actors_["1150ui_story"].transform.localEulerAngles = arg_723_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_726_1 = 0
			local var_726_2 = 0.725

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_3 = arg_723_1:FormatText(arg_723_1:GetWordFromCfg(1105006172).content)

				arg_723_1.text_.text = var_726_3

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_5 = 29 <= 0 and var_726_2 or var_726_2 * (utf8.len(var_726_3) / 29)

				if (29 <= 0 and var_726_2 or var_726_2 * (utf8.len(var_726_3) / 29)) > 0 and var_726_2 < var_726_5 then
					arg_723_1.talkMaxDuration = var_726_5

					if var_726_5 + var_726_1 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_5 + var_726_1
					end
				end

				arg_723_1.text_.text = var_726_3
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_6 = math.max(var_726_2, arg_723_1.talkMaxDuration)

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_6 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_1) / var_726_6

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_1 + var_726_6 and arg_723_1.time_ < var_726_1 + var_726_6 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_723_1:InitPlayNodeList()
	end,
	Play1105006173 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 1105006173
		arg_727_1.duration_ = 4

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play1105006174(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 and not isNil(arg_727_1.actors_["1150ui_story"]) and arg_727_1.var_.characterEffect1150ui_story == nil then
				arg_727_1.var_.characterEffect1150ui_story = arg_727_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_0 = 0.200000002980232

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_0 and not isNil(arg_727_1.actors_["1150ui_story"]) then
				if arg_727_1.var_.characterEffect1150ui_story and not isNil(arg_727_1.actors_["1150ui_story"]) then
					arg_727_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_727_1.time_ >= 0 + var_730_0 and arg_727_1.time_ < 0 + var_730_0 + arg_730_0 and not isNil(arg_727_1.actors_["1150ui_story"]) and arg_727_1.var_.characterEffect1150ui_story then
				arg_727_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_730_2 = arg_727_1.actors_["1150ui_story"].transform

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.var_.moveOldPos1150ui_story = var_730_2.localPosition
			end

			local var_730_3 = 0.001

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_3 then
				var_730_2.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_727_1.time_ - 0) / var_730_3)
				var_730_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_2.position).x, (manager.ui.mainCamera.transform.position - var_730_2.position).y, (manager.ui.mainCamera.transform.position - var_730_2.position).z)
				var_730_2.localEulerAngles.z = 0
				var_730_2.localEulerAngles.x = 0
				var_730_2.localEulerAngles = var_730_2.localEulerAngles
			end

			if arg_727_1.time_ >= 0 + var_730_3 and arg_727_1.time_ < 0 + var_730_3 + arg_730_0 then
				var_730_2.localPosition = Vector3.New(0, -1.01, -6.2)
				var_730_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_2.position).x, (manager.ui.mainCamera.transform.position - var_730_2.position).y, (manager.ui.mainCamera.transform.position - var_730_2.position).z)
				var_730_2.localEulerAngles.z = 0
				var_730_2.localEulerAngles.x = 0
				var_730_2.localEulerAngles = var_730_2.localEulerAngles
			end

			local var_730_4 = 0
			local var_730_5 = 0.4

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_4 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				arg_727_1.leftNameTxt_.text = arg_727_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_6 = arg_727_1:GetWordFromCfg(1105006173)
				local var_730_7 = arg_727_1:FormatText(var_730_6.content)

				arg_727_1.text_.text = var_730_7

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_9 = 16 <= 0 and var_730_5 or var_730_5 * (utf8.len(var_730_7) / 16)

				if (16 <= 0 and var_730_5 or var_730_5 * (utf8.len(var_730_7) / 16)) > 0 and var_730_5 < var_730_9 then
					arg_727_1.talkMaxDuration = var_730_9

					if var_730_9 + var_730_4 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_9 + var_730_4
					end
				end

				arg_727_1.text_.text = var_730_7
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb") ~= 0 then
					local var_730_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb") / 1000

					if var_730_10 + var_730_4 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_10 + var_730_4
					end

					if var_730_6.prefab_name ~= "" and arg_727_1.actors_[var_730_6.prefab_name] ~= nil then
						local var_730_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_727_1.actors_[var_730_6.prefab_name].transform, "story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb")

						arg_727_1:RecordAudio("1105006173", var_730_11)
						arg_727_1:RecordAudio("1105006173", var_730_11)
					else
						arg_727_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb")
					end

					arg_727_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006173", "story_v_side_new_1105006.awb")
				end

				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_12 = math.max(var_730_5, arg_727_1.talkMaxDuration)

			if var_730_4 <= arg_727_1.time_ and arg_727_1.time_ < var_730_4 + var_730_12 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_4) / var_730_12

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_4 + var_730_12 and arg_727_1.time_ < var_730_4 + var_730_12 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play1105006174 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 1105006174
		arg_731_1.duration_ = 5.63

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play1105006175(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			if 3.03333333333334 < arg_731_1.time_ and arg_731_1.time_ <= 3.03333333333334 + arg_734_0 then
				arg_731_1.allBtn_.enabled = false
			end

			if arg_731_1.time_ >= 3.03333333333334 + 0.0999999999999996 and arg_731_1.time_ < 3.03333333333334 + 0.0999999999999996 + arg_734_0 then
				arg_731_1.allBtn_.enabled = true
			end

			if 1.03333333333333 < arg_731_1.time_ and arg_731_1.time_ <= 1.03333333333333 + arg_734_0 then
				local var_734_0 = arg_731_1.bgs_.ST11

				arg_731_1.bgs_.ST11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_734_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_734_1 = var_734_0:GetComponent("SpriteRenderer")

				if var_734_1 and var_734_1.sprite then
					local var_734_2 = 2 * (var_734_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_734_0.transform.localScale = Vector3.New(var_734_2 / var_734_1.sprite.bounds.size.y < var_734_2 * manager.ui.mainCameraCom_.aspect / var_734_1.sprite.bounds.size.x and var_734_2 * manager.ui.mainCameraCom_.aspect / var_734_1.sprite.bounds.size.x or var_734_2 / var_734_1.sprite.bounds.size.y, var_734_2 / var_734_1.sprite.bounds.size.y < var_734_2 * manager.ui.mainCameraCom_.aspect / var_734_1.sprite.bounds.size.x and var_734_2 * manager.ui.mainCameraCom_.aspect / var_734_1.sprite.bounds.size.x or var_734_2 / var_734_1.sprite.bounds.size.y, 0)
				end

				for iter_734_0, iter_734_1 in pairs(arg_731_1.bgs_) do
					if iter_734_0 ~= "ST11" then
						iter_734_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_734_3 = 0

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_3 + arg_734_0 then
				arg_731_1.mask_.enabled = true
				arg_731_1.mask_.raycastTarget = true

				arg_731_1:SetGaussion(false)
			end

			local var_734_4 = 1.03333333333333

			if var_734_3 <= arg_731_1.time_ and arg_731_1.time_ < var_734_3 + var_734_4 then
				local var_734_5 = Color.New(0, 0, 0)

				var_734_5.a = Mathf.Lerp(0, 1, (arg_731_1.time_ - var_734_3) / var_734_4)
				arg_731_1.mask_.color = var_734_5
			end

			if arg_731_1.time_ >= var_734_3 + var_734_4 and arg_731_1.time_ < var_734_3 + var_734_4 + arg_734_0 then
				local var_734_6 = Color.New(0, 0, 0)

				var_734_6.a = 1
				arg_731_1.mask_.color = var_734_6
			end

			local var_734_7 = 1.03333333333333

			if 1.03333333333333 < arg_731_1.time_ and arg_731_1.time_ <= var_734_7 + arg_734_0 then
				arg_731_1.mask_.enabled = true
				arg_731_1.mask_.raycastTarget = true

				arg_731_1:SetGaussion(false)
			end

			local var_734_8 = 2

			if var_734_7 <= arg_731_1.time_ and arg_731_1.time_ < var_734_7 + var_734_8 then
				local var_734_9 = Color.New(0, 0, 0)

				var_734_9.a = Mathf.Lerp(1, 0, (arg_731_1.time_ - var_734_7) / var_734_8)
				arg_731_1.mask_.color = var_734_9
			end

			if arg_731_1.time_ >= var_734_7 + var_734_8 and arg_731_1.time_ < var_734_7 + var_734_8 + arg_734_0 then
				local var_734_10 = Color.New(0, 0, 0)

				arg_731_1.mask_.enabled = false
				var_734_10.a = 0
				arg_731_1.mask_.color = var_734_10
			end

			local var_734_11 = arg_731_1.actors_["1150ui_story"].transform

			if 1.00360023312581 < arg_731_1.time_ and arg_731_1.time_ <= 1.00360023312581 + arg_734_0 then
				arg_731_1.var_.moveOldPos1150ui_story = var_734_11.localPosition
			end

			local var_734_12 = 0.001

			if 1.00360023312581 <= arg_731_1.time_ and arg_731_1.time_ < 1.00360023312581 + var_734_12 then
				var_734_11.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_731_1.time_ - 1.00360023312581) / var_734_12)
				var_734_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_11.position).x, (manager.ui.mainCamera.transform.position - var_734_11.position).y, (manager.ui.mainCamera.transform.position - var_734_11.position).z)
				var_734_11.localEulerAngles.z = 0
				var_734_11.localEulerAngles.x = 0
				var_734_11.localEulerAngles = var_734_11.localEulerAngles
			end

			if arg_731_1.time_ >= 1.00360023312581 + var_734_12 and arg_731_1.time_ < 1.00360023312581 + var_734_12 + arg_734_0 then
				var_734_11.localPosition = Vector3.New(0, 100, 0)
				var_734_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_11.position).x, (manager.ui.mainCamera.transform.position - var_734_11.position).y, (manager.ui.mainCamera.transform.position - var_734_11.position).z)
				var_734_11.localEulerAngles.z = 0
				var_734_11.localEulerAngles.x = 0
				var_734_11.localEulerAngles = var_734_11.localEulerAngles
			end

			local var_734_13 = arg_731_1.actors_["1150ui_story"].transform

			if 3 < arg_731_1.time_ and arg_731_1.time_ <= 3 + arg_734_0 then
				arg_731_1.var_.moveOldPos1150ui_story = var_734_13.localPosition
			end

			local var_734_14 = 0.001

			if 3 <= arg_731_1.time_ and arg_731_1.time_ < 3 + var_734_14 then
				var_734_13.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_731_1.time_ - 3) / var_734_14)
				var_734_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_13.position).x, (manager.ui.mainCamera.transform.position - var_734_13.position).y, (manager.ui.mainCamera.transform.position - var_734_13.position).z)
				var_734_13.localEulerAngles.z = 0
				var_734_13.localEulerAngles.x = 0
				var_734_13.localEulerAngles = var_734_13.localEulerAngles
			end

			if arg_731_1.time_ >= 3 + var_734_14 and arg_731_1.time_ < 3 + var_734_14 + arg_734_0 then
				var_734_13.localPosition = Vector3.New(0, -1.01, -6.2)
				var_734_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_734_13.position).x, (manager.ui.mainCamera.transform.position - var_734_13.position).y, (manager.ui.mainCamera.transform.position - var_734_13.position).z)
				var_734_13.localEulerAngles.z = 0
				var_734_13.localEulerAngles.x = 0
				var_734_13.localEulerAngles = var_734_13.localEulerAngles
			end

			local var_734_15 = arg_731_1.actors_["1150ui_story"]

			if 3 < arg_731_1.time_ and arg_731_1.time_ <= 3 + arg_734_0 and not isNil(var_734_15) and arg_731_1.var_.characterEffect1150ui_story == nil then
				arg_731_1.var_.characterEffect1150ui_story = var_734_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_16 = 0.200000002980232

			if 3 <= arg_731_1.time_ and arg_731_1.time_ < 3 + var_734_16 and not isNil(var_734_15) then
				if arg_731_1.var_.characterEffect1150ui_story and not isNil(var_734_15) then
					arg_731_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_731_1.time_ >= 3 + var_734_16 and arg_731_1.time_ < 3 + var_734_16 + arg_734_0 and not isNil(var_734_15) and arg_731_1.var_.characterEffect1150ui_story then
				arg_731_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 3 < arg_731_1.time_ and arg_731_1.time_ <= 3 + arg_734_0 then
				arg_731_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			if 3 < arg_731_1.time_ and arg_731_1.time_ <= 3 + arg_734_0 then
				arg_731_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_731_1.frameCnt_ <= 1 then
				arg_731_1.dialog_:SetActive(false)
			end

			local var_734_18 = 3.03333333333334
			local var_734_19 = 0.225

			if 3.03333333333334 < arg_731_1.time_ and arg_731_1.time_ <= var_734_18 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0

				arg_731_1.dialog_:SetActive(true)

				arg_731_1.dialogCg_.alpha = 0

				local var_734_20 = LeanTween.value(arg_731_1.dialog_, 0, 1, 0.3)

				var_734_20:setOnUpdate(LuaHelper.FloatAction(function(arg_735_0)
					arg_731_1.dialogCg_.alpha = arg_735_0
				end))
				var_734_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_731_1.dialog_)
					var_734_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_731_1.duration_ = arg_731_1.duration_ + 0.3

				SetActive(arg_731_1.leftNameGo_, true)

				arg_731_1.leftNameTxt_.text = arg_731_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_21 = arg_731_1:GetWordFromCfg(1105006174)
				local var_734_22 = arg_731_1:FormatText(var_734_21.content)

				arg_731_1.text_.text = var_734_22

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_24 = 9 <= 0 and var_734_19 or var_734_19 * (utf8.len(var_734_22) / 9)

				if (9 <= 0 and var_734_19 or var_734_19 * (utf8.len(var_734_22) / 9)) > 0 and var_734_19 < var_734_24 then
					arg_731_1.talkMaxDuration = var_734_24
					var_734_18 = var_734_18 + 0.3

					if var_734_24 + var_734_18 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_24 + var_734_18
					end
				end

				arg_731_1.text_.text = var_734_22
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb") ~= 0 then
					local var_734_25 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb") / 1000

					if var_734_25 + var_734_18 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_25 + var_734_18
					end

					if var_734_21.prefab_name ~= "" and arg_731_1.actors_[var_734_21.prefab_name] ~= nil then
						local var_734_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_21.prefab_name].transform, "story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb")

						arg_731_1:RecordAudio("1105006174", var_734_26)
						arg_731_1:RecordAudio("1105006174", var_734_26)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006174", "story_v_side_new_1105006.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_27 = var_734_18 + 0.3
			local var_734_28 = math.max(var_734_19, arg_731_1.talkMaxDuration)

			if var_734_18 + 0.3 <= arg_731_1.time_ and arg_731_1.time_ < var_734_27 + var_734_28 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_27) / var_734_28

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_27 + var_734_28 and arg_731_1.time_ < var_734_27 + var_734_28 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0297331002075225,
				className = "StoryMoveNode",
				startTime = 1.00360023312581,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	Play1105006175 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1105006175
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1105006176(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 and not isNil(arg_737_1.actors_["1150ui_story"]) and arg_737_1.var_.characterEffect1150ui_story == nil then
				arg_737_1.var_.characterEffect1150ui_story = arg_737_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_0 = 0.200000002980232

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_0 and not isNil(arg_737_1.actors_["1150ui_story"]) then
				if arg_737_1.var_.characterEffect1150ui_story and not isNil(arg_737_1.actors_["1150ui_story"]) then
					arg_737_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_737_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_737_1.time_ - 0) / var_740_0)
				end
			end

			if arg_737_1.time_ >= 0 + var_740_0 and arg_737_1.time_ < 0 + var_740_0 + arg_740_0 and not isNil(arg_737_1.actors_["1150ui_story"]) and arg_737_1.var_.characterEffect1150ui_story then
				arg_737_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_737_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_740_1 = 0
			local var_740_2 = 1.1

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_1 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, true)
				arg_737_1.iconController_:SetSelectedState("hero")

				arg_737_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_737_1.callingController_:SetSelectedState("normal")

				arg_737_1.keyicon_.color = Color.New(1, 1, 1)
				arg_737_1.icon_.color = Color.New(1, 1, 1)

				local var_740_3 = arg_737_1:FormatText(arg_737_1:GetWordFromCfg(1105006175).content)

				arg_737_1.text_.text = var_740_3

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_5 = 44 <= 0 and var_740_2 or var_740_2 * (utf8.len(var_740_3) / 44)

				if (44 <= 0 and var_740_2 or var_740_2 * (utf8.len(var_740_3) / 44)) > 0 and var_740_2 < var_740_5 then
					arg_737_1.talkMaxDuration = var_740_5

					if var_740_5 + var_740_1 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_5 + var_740_1
					end
				end

				arg_737_1.text_.text = var_740_3
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_6 = math.max(var_740_2, arg_737_1.talkMaxDuration)

			if var_740_1 <= arg_737_1.time_ and arg_737_1.time_ < var_740_1 + var_740_6 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_1) / var_740_6

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_1 + var_740_6 and arg_737_1.time_ < var_740_1 + var_740_6 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1105006176 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1105006176
		arg_741_1.duration_ = 2.87

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1105006177(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 and not isNil(arg_741_1.actors_["1150ui_story"]) and arg_741_1.var_.characterEffect1150ui_story == nil then
				arg_741_1.var_.characterEffect1150ui_story = arg_741_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_744_0 = 0.200000002980232

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_0 and not isNil(arg_741_1.actors_["1150ui_story"]) then
				if arg_741_1.var_.characterEffect1150ui_story and not isNil(arg_741_1.actors_["1150ui_story"]) then
					arg_741_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_741_1.time_ >= 0 + var_744_0 and arg_741_1.time_ < 0 + var_744_0 + arg_744_0 and not isNil(arg_741_1.actors_["1150ui_story"]) and arg_741_1.var_.characterEffect1150ui_story then
				arg_741_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_744_2 = 0
			local var_744_3 = 0.375

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_2 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_4 = arg_741_1:GetWordFromCfg(1105006176)
				local var_744_5 = arg_741_1:FormatText(var_744_4.content)

				arg_741_1.text_.text = var_744_5

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_7 = 15 <= 0 and var_744_3 or var_744_3 * (utf8.len(var_744_5) / 15)

				if (15 <= 0 and var_744_3 or var_744_3 * (utf8.len(var_744_5) / 15)) > 0 and var_744_3 < var_744_7 then
					arg_741_1.talkMaxDuration = var_744_7

					if var_744_7 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_7 + var_744_2
					end
				end

				arg_741_1.text_.text = var_744_5
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb") ~= 0 then
					local var_744_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb") / 1000

					if var_744_8 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_8 + var_744_2
					end

					if var_744_4.prefab_name ~= "" and arg_741_1.actors_[var_744_4.prefab_name] ~= nil then
						local var_744_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_4.prefab_name].transform, "story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb")

						arg_741_1:RecordAudio("1105006176", var_744_9)
						arg_741_1:RecordAudio("1105006176", var_744_9)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006176", "story_v_side_new_1105006.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_10 = math.max(var_744_3, arg_741_1.talkMaxDuration)

			if var_744_2 <= arg_741_1.time_ and arg_741_1.time_ < var_744_2 + var_744_10 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_2) / var_744_10

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_2 + var_744_10 and arg_741_1.time_ < var_744_2 + var_744_10 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1105006177 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1105006177
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1105006178(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1.var_.moveOldPos1150ui_story = arg_745_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_748_0 = 0.001

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_0 then
				arg_745_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_745_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_745_1.time_ - 0) / var_748_0)
				arg_745_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_745_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1150ui_story"].transform.position).z)
				arg_745_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_745_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_745_1.actors_["1150ui_story"].transform.localEulerAngles = arg_745_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_745_1.time_ >= 0 + var_748_0 and arg_745_1.time_ < 0 + var_748_0 + arg_748_0 then
				arg_745_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_745_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_745_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_745_1.actors_["1150ui_story"].transform.position).z)
				arg_745_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_745_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_745_1.actors_["1150ui_story"].transform.localEulerAngles = arg_745_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_748_1 = 0
			local var_748_2 = 1.4

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, false)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_3 = arg_745_1:FormatText(arg_745_1:GetWordFromCfg(1105006177).content)

				arg_745_1.text_.text = var_748_3

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_5 = 56 <= 0 and var_748_2 or var_748_2 * (utf8.len(var_748_3) / 56)

				if (56 <= 0 and var_748_2 or var_748_2 * (utf8.len(var_748_3) / 56)) > 0 and var_748_2 < var_748_5 then
					arg_745_1.talkMaxDuration = var_748_5

					if var_748_5 + var_748_1 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_5 + var_748_1
					end
				end

				arg_745_1.text_.text = var_748_3
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_6 = math.max(var_748_2, arg_745_1.talkMaxDuration)

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_6 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_1) / var_748_6

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_1 + var_748_6 and arg_745_1.time_ < var_748_1 + var_748_6 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_745_1:InitPlayNodeList()
	end,
	Play1105006178 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1105006178
		arg_749_1.duration_ = 2.13

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1105006179(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 and not isNil(arg_749_1.actors_["1150ui_story"]) and arg_749_1.var_.characterEffect1150ui_story == nil then
				arg_749_1.var_.characterEffect1150ui_story = arg_749_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_752_0 = 0.200000002980232

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_0 and not isNil(arg_749_1.actors_["1150ui_story"]) then
				if arg_749_1.var_.characterEffect1150ui_story and not isNil(arg_749_1.actors_["1150ui_story"]) then
					arg_749_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_749_1.time_ >= 0 + var_752_0 and arg_749_1.time_ < 0 + var_752_0 + arg_752_0 and not isNil(arg_749_1.actors_["1150ui_story"]) and arg_749_1.var_.characterEffect1150ui_story then
				arg_749_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_752_2 = arg_749_1.actors_["1150ui_story"].transform

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1.var_.moveOldPos1150ui_story = var_752_2.localPosition
			end

			local var_752_3 = 0.001

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_3 then
				var_752_2.localPosition = Vector3.Lerp(arg_749_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_749_1.time_ - 0) / var_752_3)
				var_752_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_752_2.position).x, (manager.ui.mainCamera.transform.position - var_752_2.position).y, (manager.ui.mainCamera.transform.position - var_752_2.position).z)
				var_752_2.localEulerAngles.z = 0
				var_752_2.localEulerAngles.x = 0
				var_752_2.localEulerAngles = var_752_2.localEulerAngles
			end

			if arg_749_1.time_ >= 0 + var_752_3 and arg_749_1.time_ < 0 + var_752_3 + arg_752_0 then
				var_752_2.localPosition = Vector3.New(0, -1.01, -6.2)
				var_752_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_752_2.position).x, (manager.ui.mainCamera.transform.position - var_752_2.position).y, (manager.ui.mainCamera.transform.position - var_752_2.position).z)
				var_752_2.localEulerAngles.z = 0
				var_752_2.localEulerAngles.x = 0
				var_752_2.localEulerAngles = var_752_2.localEulerAngles
			end

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_2")
			end

			local var_752_4 = 0
			local var_752_5 = 0.3

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_4 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				arg_749_1.leftNameTxt_.text = arg_749_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_6 = arg_749_1:GetWordFromCfg(1105006178)
				local var_752_7 = arg_749_1:FormatText(var_752_6.content)

				arg_749_1.text_.text = var_752_7

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_9 = 12 <= 0 and var_752_5 or var_752_5 * (utf8.len(var_752_7) / 12)

				if (12 <= 0 and var_752_5 or var_752_5 * (utf8.len(var_752_7) / 12)) > 0 and var_752_5 < var_752_9 then
					arg_749_1.talkMaxDuration = var_752_9

					if var_752_9 + var_752_4 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_9 + var_752_4
					end
				end

				arg_749_1.text_.text = var_752_7
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb") ~= 0 then
					local var_752_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb") / 1000

					if var_752_10 + var_752_4 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_10 + var_752_4
					end

					if var_752_6.prefab_name ~= "" and arg_749_1.actors_[var_752_6.prefab_name] ~= nil then
						local var_752_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_749_1.actors_[var_752_6.prefab_name].transform, "story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb")

						arg_749_1:RecordAudio("1105006178", var_752_11)
						arg_749_1:RecordAudio("1105006178", var_752_11)
					else
						arg_749_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb")
					end

					arg_749_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006178", "story_v_side_new_1105006.awb")
				end

				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_12 = math.max(var_752_5, arg_749_1.talkMaxDuration)

			if var_752_4 <= arg_749_1.time_ and arg_749_1.time_ < var_752_4 + var_752_12 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_4) / var_752_12

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_4 + var_752_12 and arg_749_1.time_ < var_752_4 + var_752_12 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_749_1:InitPlayNodeList()
	end,
	Play1105006179 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1105006179
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1105006180(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 and not isNil(arg_753_1.actors_["1150ui_story"]) and arg_753_1.var_.characterEffect1150ui_story == nil then
				arg_753_1.var_.characterEffect1150ui_story = arg_753_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_756_0 = 0.200000002980232

			if 0 <= arg_753_1.time_ and arg_753_1.time_ < 0 + var_756_0 and not isNil(arg_753_1.actors_["1150ui_story"]) then
				if arg_753_1.var_.characterEffect1150ui_story and not isNil(arg_753_1.actors_["1150ui_story"]) then
					arg_753_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_753_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_753_1.time_ - 0) / var_756_0)
				end
			end

			if arg_753_1.time_ >= 0 + var_756_0 and arg_753_1.time_ < 0 + var_756_0 + arg_756_0 and not isNil(arg_753_1.actors_["1150ui_story"]) and arg_753_1.var_.characterEffect1150ui_story then
				arg_753_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_753_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_756_1 = 0
			local var_756_2 = 0.9

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= var_756_1 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				arg_753_1.leftNameTxt_.text = arg_753_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, true)
				arg_753_1.iconController_:SetSelectedState("hero")

				arg_753_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_753_1.callingController_:SetSelectedState("normal")

				arg_753_1.keyicon_.color = Color.New(1, 1, 1)
				arg_753_1.icon_.color = Color.New(1, 1, 1)

				local var_756_3 = arg_753_1:FormatText(arg_753_1:GetWordFromCfg(1105006179).content)

				arg_753_1.text_.text = var_756_3

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_5 = 36 <= 0 and var_756_2 or var_756_2 * (utf8.len(var_756_3) / 36)

				if (36 <= 0 and var_756_2 or var_756_2 * (utf8.len(var_756_3) / 36)) > 0 and var_756_2 < var_756_5 then
					arg_753_1.talkMaxDuration = var_756_5

					if var_756_5 + var_756_1 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_5 + var_756_1
					end
				end

				arg_753_1.text_.text = var_756_3
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_6 = math.max(var_756_2, arg_753_1.talkMaxDuration)

			if var_756_1 <= arg_753_1.time_ and arg_753_1.time_ < var_756_1 + var_756_6 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_1) / var_756_6

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_1 + var_756_6 and arg_753_1.time_ < var_756_1 + var_756_6 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1105006180 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1105006180
		arg_757_1.duration_ = 3.27

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play1105006181(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 and not isNil(arg_757_1.actors_["1150ui_story"]) and arg_757_1.var_.characterEffect1150ui_story == nil then
				arg_757_1.var_.characterEffect1150ui_story = arg_757_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_760_0 = 0.200000002980232

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_0 and not isNil(arg_757_1.actors_["1150ui_story"]) then
				if arg_757_1.var_.characterEffect1150ui_story and not isNil(arg_757_1.actors_["1150ui_story"]) then
					arg_757_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_757_1.time_ >= 0 + var_760_0 and arg_757_1.time_ < 0 + var_760_0 + arg_760_0 and not isNil(arg_757_1.actors_["1150ui_story"]) and arg_757_1.var_.characterEffect1150ui_story then
				arg_757_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_760_2 = 0
			local var_760_3 = 0.375

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= var_760_2 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				arg_757_1.leftNameTxt_.text = arg_757_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_4 = arg_757_1:GetWordFromCfg(1105006180)
				local var_760_5 = arg_757_1:FormatText(var_760_4.content)

				arg_757_1.text_.text = var_760_5

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_7 = 15 <= 0 and var_760_3 or var_760_3 * (utf8.len(var_760_5) / 15)

				if (15 <= 0 and var_760_3 or var_760_3 * (utf8.len(var_760_5) / 15)) > 0 and var_760_3 < var_760_7 then
					arg_757_1.talkMaxDuration = var_760_7

					if var_760_7 + var_760_2 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_7 + var_760_2
					end
				end

				arg_757_1.text_.text = var_760_5
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb") ~= 0 then
					local var_760_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb") / 1000

					if var_760_8 + var_760_2 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_8 + var_760_2
					end

					if var_760_4.prefab_name ~= "" and arg_757_1.actors_[var_760_4.prefab_name] ~= nil then
						local var_760_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_757_1.actors_[var_760_4.prefab_name].transform, "story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb")

						arg_757_1:RecordAudio("1105006180", var_760_9)
						arg_757_1:RecordAudio("1105006180", var_760_9)
					else
						arg_757_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb")
					end

					arg_757_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006180", "story_v_side_new_1105006.awb")
				end

				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_10 = math.max(var_760_3, arg_757_1.talkMaxDuration)

			if var_760_2 <= arg_757_1.time_ and arg_757_1.time_ < var_760_2 + var_760_10 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - var_760_2) / var_760_10

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= var_760_2 + var_760_10 and arg_757_1.time_ < var_760_2 + var_760_10 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play1105006181 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1105006181
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1105006182(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 and not isNil(arg_761_1.actors_["1150ui_story"]) and arg_761_1.var_.characterEffect1150ui_story == nil then
				arg_761_1.var_.characterEffect1150ui_story = arg_761_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_764_0 = 0.200000002980232

			if 0 <= arg_761_1.time_ and arg_761_1.time_ < 0 + var_764_0 and not isNil(arg_761_1.actors_["1150ui_story"]) then
				if arg_761_1.var_.characterEffect1150ui_story and not isNil(arg_761_1.actors_["1150ui_story"]) then
					arg_761_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_761_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_761_1.time_ - 0) / var_764_0)
				end
			end

			if arg_761_1.time_ >= 0 + var_764_0 and arg_761_1.time_ < 0 + var_764_0 + arg_764_0 and not isNil(arg_761_1.actors_["1150ui_story"]) and arg_761_1.var_.characterEffect1150ui_story then
				arg_761_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_761_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_764_1 = 0
			local var_764_2 = 0.25

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= var_764_1 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				arg_761_1.leftNameTxt_.text = arg_761_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, true)
				arg_761_1.iconController_:SetSelectedState("hero")

				arg_761_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_761_1.callingController_:SetSelectedState("normal")

				arg_761_1.keyicon_.color = Color.New(1, 1, 1)
				arg_761_1.icon_.color = Color.New(1, 1, 1)

				local var_764_3 = arg_761_1:FormatText(arg_761_1:GetWordFromCfg(1105006181).content)

				arg_761_1.text_.text = var_764_3

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_5 = 10 <= 0 and var_764_2 or var_764_2 * (utf8.len(var_764_3) / 10)

				if (10 <= 0 and var_764_2 or var_764_2 * (utf8.len(var_764_3) / 10)) > 0 and var_764_2 < var_764_5 then
					arg_761_1.talkMaxDuration = var_764_5

					if var_764_5 + var_764_1 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_5 + var_764_1
					end
				end

				arg_761_1.text_.text = var_764_3
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_6 = math.max(var_764_2, arg_761_1.talkMaxDuration)

			if var_764_1 <= arg_761_1.time_ and arg_761_1.time_ < var_764_1 + var_764_6 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_1) / var_764_6

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_1 + var_764_6 and arg_761_1.time_ < var_764_1 + var_764_6 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play1105006182 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1105006182
		arg_765_1.duration_ = 7.1

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1105006183(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 and not isNil(arg_765_1.actors_["1150ui_story"]) and arg_765_1.var_.characterEffect1150ui_story == nil then
				arg_765_1.var_.characterEffect1150ui_story = arg_765_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_768_0 = 0.200000002980232

			if 0 <= arg_765_1.time_ and arg_765_1.time_ < 0 + var_768_0 and not isNil(arg_765_1.actors_["1150ui_story"]) then
				if arg_765_1.var_.characterEffect1150ui_story and not isNil(arg_765_1.actors_["1150ui_story"]) then
					arg_765_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_765_1.time_ >= 0 + var_768_0 and arg_765_1.time_ < 0 + var_768_0 + arg_768_0 and not isNil(arg_765_1.actors_["1150ui_story"]) and arg_765_1.var_.characterEffect1150ui_story then
				arg_765_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 then
				arg_765_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_768_2 = 0
			local var_768_3 = 0.725

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= var_768_2 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				arg_765_1.leftNameTxt_.text = arg_765_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, false)
				arg_765_1.callingController_:SetSelectedState("normal")

				local var_768_4 = arg_765_1:GetWordFromCfg(1105006182)
				local var_768_5 = arg_765_1:FormatText(var_768_4.content)

				arg_765_1.text_.text = var_768_5

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_7 = 29 <= 0 and var_768_3 or var_768_3 * (utf8.len(var_768_5) / 29)

				if (29 <= 0 and var_768_3 or var_768_3 * (utf8.len(var_768_5) / 29)) > 0 and var_768_3 < var_768_7 then
					arg_765_1.talkMaxDuration = var_768_7

					if var_768_7 + var_768_2 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_7 + var_768_2
					end
				end

				arg_765_1.text_.text = var_768_5
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb") ~= 0 then
					local var_768_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb") / 1000

					if var_768_8 + var_768_2 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_8 + var_768_2
					end

					if var_768_4.prefab_name ~= "" and arg_765_1.actors_[var_768_4.prefab_name] ~= nil then
						local var_768_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_765_1.actors_[var_768_4.prefab_name].transform, "story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb")

						arg_765_1:RecordAudio("1105006182", var_768_9)
						arg_765_1:RecordAudio("1105006182", var_768_9)
					else
						arg_765_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb")
					end

					arg_765_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006182", "story_v_side_new_1105006.awb")
				end

				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_10 = math.max(var_768_3, arg_765_1.talkMaxDuration)

			if var_768_2 <= arg_765_1.time_ and arg_765_1.time_ < var_768_2 + var_768_10 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_2) / var_768_10

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_2 + var_768_10 and arg_765_1.time_ < var_768_2 + var_768_10 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1105006183 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1105006183
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1105006184(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1.var_.moveOldPos1150ui_story = arg_769_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_772_0 = 0.001

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_0 then
				arg_769_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_769_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_769_1.time_ - 0) / var_772_0)
				arg_769_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_769_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1150ui_story"].transform.position).z)
				arg_769_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_769_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_769_1.actors_["1150ui_story"].transform.localEulerAngles = arg_769_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_769_1.time_ >= 0 + var_772_0 and arg_769_1.time_ < 0 + var_772_0 + arg_772_0 then
				arg_769_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_769_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_769_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1150ui_story"].transform.position).z)
				arg_769_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_769_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_769_1.actors_["1150ui_story"].transform.localEulerAngles = arg_769_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_772_1 = 0
			local var_772_2 = 0.925

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, false)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_3 = arg_769_1:FormatText(arg_769_1:GetWordFromCfg(1105006183).content)

				arg_769_1.text_.text = var_772_3

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_5 = 37 <= 0 and var_772_2 or var_772_2 * (utf8.len(var_772_3) / 37)

				if (37 <= 0 and var_772_2 or var_772_2 * (utf8.len(var_772_3) / 37)) > 0 and var_772_2 < var_772_5 then
					arg_769_1.talkMaxDuration = var_772_5

					if var_772_5 + var_772_1 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_5 + var_772_1
					end
				end

				arg_769_1.text_.text = var_772_3
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_6 = math.max(var_772_2, arg_769_1.talkMaxDuration)

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_6 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_1) / var_772_6

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_1 + var_772_6 and arg_769_1.time_ < var_772_1 + var_772_6 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_769_1:InitPlayNodeList()
	end,
	Play1105006184 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1105006184
		arg_773_1.duration_ = 11.53

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1105006185(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 and not isNil(arg_773_1.actors_["1150ui_story"]) and arg_773_1.var_.characterEffect1150ui_story == nil then
				arg_773_1.var_.characterEffect1150ui_story = arg_773_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_0 = 0.200000002980232

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_0 and not isNil(arg_773_1.actors_["1150ui_story"]) then
				if arg_773_1.var_.characterEffect1150ui_story and not isNil(arg_773_1.actors_["1150ui_story"]) then
					arg_773_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_773_1.time_ >= 0 + var_776_0 and arg_773_1.time_ < 0 + var_776_0 + arg_776_0 and not isNil(arg_773_1.actors_["1150ui_story"]) and arg_773_1.var_.characterEffect1150ui_story then
				arg_773_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_776_2 = arg_773_1.actors_["1150ui_story"].transform

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1.var_.moveOldPos1150ui_story = var_776_2.localPosition
			end

			local var_776_3 = 0.001

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_3 then
				var_776_2.localPosition = Vector3.Lerp(arg_773_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_773_1.time_ - 0) / var_776_3)
				var_776_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_776_2.position).x, (manager.ui.mainCamera.transform.position - var_776_2.position).y, (manager.ui.mainCamera.transform.position - var_776_2.position).z)
				var_776_2.localEulerAngles.z = 0
				var_776_2.localEulerAngles.x = 0
				var_776_2.localEulerAngles = var_776_2.localEulerAngles
			end

			if arg_773_1.time_ >= 0 + var_776_3 and arg_773_1.time_ < 0 + var_776_3 + arg_776_0 then
				var_776_2.localPosition = Vector3.New(0, -1.01, -6.2)
				var_776_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_776_2.position).x, (manager.ui.mainCamera.transform.position - var_776_2.position).y, (manager.ui.mainCamera.transform.position - var_776_2.position).z)
				var_776_2.localEulerAngles.z = 0
				var_776_2.localEulerAngles.x = 0
				var_776_2.localEulerAngles = var_776_2.localEulerAngles
			end

			local var_776_4 = 0
			local var_776_5 = 0.975

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= var_776_4 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, true)

				arg_773_1.leftNameTxt_.text = arg_773_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_773_1.leftNameTxt_.transform)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1.leftNameTxt_.text)
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_6 = arg_773_1:GetWordFromCfg(1105006184)
				local var_776_7 = arg_773_1:FormatText(var_776_6.content)

				arg_773_1.text_.text = var_776_7

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_9 = 39 <= 0 and var_776_5 or var_776_5 * (utf8.len(var_776_7) / 39)

				if (39 <= 0 and var_776_5 or var_776_5 * (utf8.len(var_776_7) / 39)) > 0 and var_776_5 < var_776_9 then
					arg_773_1.talkMaxDuration = var_776_9

					if var_776_9 + var_776_4 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_9 + var_776_4
					end
				end

				arg_773_1.text_.text = var_776_7
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb") ~= 0 then
					local var_776_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb") / 1000

					if var_776_10 + var_776_4 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_10 + var_776_4
					end

					if var_776_6.prefab_name ~= "" and arg_773_1.actors_[var_776_6.prefab_name] ~= nil then
						local var_776_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_773_1.actors_[var_776_6.prefab_name].transform, "story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb")

						arg_773_1:RecordAudio("1105006184", var_776_11)
						arg_773_1:RecordAudio("1105006184", var_776_11)
					else
						arg_773_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb")
					end

					arg_773_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006184", "story_v_side_new_1105006.awb")
				end

				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_12 = math.max(var_776_5, arg_773_1.talkMaxDuration)

			if var_776_4 <= arg_773_1.time_ and arg_773_1.time_ < var_776_4 + var_776_12 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_4) / var_776_12

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_4 + var_776_12 and arg_773_1.time_ < var_776_4 + var_776_12 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_773_1:InitPlayNodeList()
	end,
	Play1105006185 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1105006185
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1105006186(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 and not isNil(arg_777_1.actors_["1150ui_story"]) and arg_777_1.var_.characterEffect1150ui_story == nil then
				arg_777_1.var_.characterEffect1150ui_story = arg_777_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_780_0 = 0.200000002980232

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_0 and not isNil(arg_777_1.actors_["1150ui_story"]) then
				if arg_777_1.var_.characterEffect1150ui_story and not isNil(arg_777_1.actors_["1150ui_story"]) then
					arg_777_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_777_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_777_1.time_ - 0) / var_780_0)
				end
			end

			if arg_777_1.time_ >= 0 + var_780_0 and arg_777_1.time_ < 0 + var_780_0 + arg_780_0 and not isNil(arg_777_1.actors_["1150ui_story"]) and arg_777_1.var_.characterEffect1150ui_story then
				arg_777_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_777_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_780_1 = 0
			local var_780_2 = 0.925

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= var_780_1 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_3 = arg_777_1:FormatText(arg_777_1:GetWordFromCfg(1105006185).content)

				arg_777_1.text_.text = var_780_3

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_5 = 37 <= 0 and var_780_2 or var_780_2 * (utf8.len(var_780_3) / 37)

				if (37 <= 0 and var_780_2 or var_780_2 * (utf8.len(var_780_3) / 37)) > 0 and var_780_2 < var_780_5 then
					arg_777_1.talkMaxDuration = var_780_5

					if var_780_5 + var_780_1 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_5 + var_780_1
					end
				end

				arg_777_1.text_.text = var_780_3
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_6 = math.max(var_780_2, arg_777_1.talkMaxDuration)

			if var_780_1 <= arg_777_1.time_ and arg_777_1.time_ < var_780_1 + var_780_6 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_1) / var_780_6

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_1 + var_780_6 and arg_777_1.time_ < var_780_1 + var_780_6 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play1105006186 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1105006186
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1105006187(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 0.525

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				arg_781_1.leftNameTxt_.text = arg_781_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, true)
				arg_781_1.iconController_:SetSelectedState("hero")

				arg_781_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_781_1.callingController_:SetSelectedState("normal")

				arg_781_1.keyicon_.color = Color.New(1, 1, 1)
				arg_781_1.icon_.color = Color.New(1, 1, 1)

				local var_784_1 = arg_781_1:FormatText(arg_781_1:GetWordFromCfg(1105006186).content)

				arg_781_1.text_.text = var_784_1

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_3 = 21 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 21)

				if (21 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 21)) > 0 and var_784_0 < var_784_3 then
					arg_781_1.talkMaxDuration = var_784_3

					if var_784_3 + 0 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_3 + 0
					end
				end

				arg_781_1.text_.text = var_784_1
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_4 = math.max(var_784_0, arg_781_1.talkMaxDuration)

			if 0 <= arg_781_1.time_ and arg_781_1.time_ < 0 + var_784_4 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - 0) / var_784_4

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= 0 + var_784_4 and arg_781_1.time_ < 0 + var_784_4 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play1105006187 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1105006187
		arg_785_1.duration_ = 4.97

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1105006188(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 and not isNil(arg_785_1.actors_["1150ui_story"]) and arg_785_1.var_.characterEffect1150ui_story == nil then
				arg_785_1.var_.characterEffect1150ui_story = arg_785_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_788_0 = 0.200000002980232

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_0 and not isNil(arg_785_1.actors_["1150ui_story"]) then
				if arg_785_1.var_.characterEffect1150ui_story and not isNil(arg_785_1.actors_["1150ui_story"]) then
					arg_785_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_785_1.time_ >= 0 + var_788_0 and arg_785_1.time_ < 0 + var_788_0 + arg_788_0 and not isNil(arg_785_1.actors_["1150ui_story"]) and arg_785_1.var_.characterEffect1150ui_story then
				arg_785_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_788_2 = 0
			local var_788_3 = 0.3

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= var_788_2 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				arg_785_1.leftNameTxt_.text = arg_785_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_4 = arg_785_1:GetWordFromCfg(1105006187)
				local var_788_5 = arg_785_1:FormatText(var_788_4.content)

				arg_785_1.text_.text = var_788_5

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_7 = 12 <= 0 and var_788_3 or var_788_3 * (utf8.len(var_788_5) / 12)

				if (12 <= 0 and var_788_3 or var_788_3 * (utf8.len(var_788_5) / 12)) > 0 and var_788_3 < var_788_7 then
					arg_785_1.talkMaxDuration = var_788_7

					if var_788_7 + var_788_2 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_7 + var_788_2
					end
				end

				arg_785_1.text_.text = var_788_5
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb") ~= 0 then
					local var_788_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb") / 1000

					if var_788_8 + var_788_2 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_8 + var_788_2
					end

					if var_788_4.prefab_name ~= "" and arg_785_1.actors_[var_788_4.prefab_name] ~= nil then
						local var_788_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_785_1.actors_[var_788_4.prefab_name].transform, "story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb")

						arg_785_1:RecordAudio("1105006187", var_788_9)
						arg_785_1:RecordAudio("1105006187", var_788_9)
					else
						arg_785_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb")
					end

					arg_785_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006187", "story_v_side_new_1105006.awb")
				end

				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_10 = math.max(var_788_3, arg_785_1.talkMaxDuration)

			if var_788_2 <= arg_785_1.time_ and arg_785_1.time_ < var_788_2 + var_788_10 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_2) / var_788_10

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_2 + var_788_10 and arg_785_1.time_ < var_788_2 + var_788_10 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play1105006188 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1105006188
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1105006189(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1.var_.moveOldPos1150ui_story = arg_789_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_792_0 = 0.001

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_0 then
				arg_789_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_789_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_789_1.time_ - 0) / var_792_0)
				arg_789_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_789_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["1150ui_story"].transform.position).z)
				arg_789_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_789_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_789_1.actors_["1150ui_story"].transform.localEulerAngles = arg_789_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_789_1.time_ >= 0 + var_792_0 and arg_789_1.time_ < 0 + var_792_0 + arg_792_0 then
				arg_789_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_789_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_789_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["1150ui_story"].transform.position).z)
				arg_789_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_789_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_789_1.actors_["1150ui_story"].transform.localEulerAngles = arg_789_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_792_1 = 0
			local var_792_2 = 1.025

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= var_792_1 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, false)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_789_1.iconTrs_.gameObject, false)
				arg_789_1.callingController_:SetSelectedState("normal")

				local var_792_3 = arg_789_1:FormatText(arg_789_1:GetWordFromCfg(1105006188).content)

				arg_789_1.text_.text = var_792_3

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_5 = 41 <= 0 and var_792_2 or var_792_2 * (utf8.len(var_792_3) / 41)

				if (41 <= 0 and var_792_2 or var_792_2 * (utf8.len(var_792_3) / 41)) > 0 and var_792_2 < var_792_5 then
					arg_789_1.talkMaxDuration = var_792_5

					if var_792_5 + var_792_1 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_5 + var_792_1
					end
				end

				arg_789_1.text_.text = var_792_3
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_6 = math.max(var_792_2, arg_789_1.talkMaxDuration)

			if var_792_1 <= arg_789_1.time_ and arg_789_1.time_ < var_792_1 + var_792_6 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_1) / var_792_6

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_1 + var_792_6 and arg_789_1.time_ < var_792_1 + var_792_6 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_789_1:InitPlayNodeList()
	end,
	Play1105006189 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1105006189
		arg_793_1.duration_ = 1

		SetActive(arg_793_1.tipsGo_, true)

		arg_793_1.tipsText_.text = StoryTipsCfg[105001].name

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"

			SetActive(arg_793_1.choicesGo_, true)

			for iter_794_0, iter_794_1 in ipairs(arg_793_1.choices_) do
				SetActive(iter_794_1.go, iter_794_0 <= 2)
			end

			arg_793_1.choices_[1].txt.text = arg_793_1:FormatText(StoryChoiceCfg[1068].name)
			arg_793_1.choices_[2].txt.text = arg_793_1:FormatText(StoryChoiceCfg[1069].name)
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				PlayerAction.UseStoryTrigger(1050013, 210500106, 1105006189, 1)
				arg_793_0:Play1105006190(arg_793_1)
			end

			if arg_795_0 == 2 then
				PlayerAction.UseStoryTrigger(1050013, 210500106, 1105006189, 2)
				arg_793_0:Play1105006190(arg_793_1)
			end

			arg_793_1:RecordChoiceLog(1105006189, 1068, 1069)
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			return
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play1105006190 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1105006190
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1105006191(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			local var_800_0 = 1.1

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, false)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_1 = arg_797_1:FormatText(arg_797_1:GetWordFromCfg(1105006190).content)

				arg_797_1.text_.text = var_800_1

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_3 = 44 <= 0 and var_800_0 or var_800_0 * (utf8.len(var_800_1) / 44)

				if (44 <= 0 and var_800_0 or var_800_0 * (utf8.len(var_800_1) / 44)) > 0 and var_800_0 < var_800_3 then
					arg_797_1.talkMaxDuration = var_800_3

					if var_800_3 + 0 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_3 + 0
					end
				end

				arg_797_1.text_.text = var_800_1
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_4 = math.max(var_800_0, arg_797_1.talkMaxDuration)

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_4 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - 0) / var_800_4

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= 0 + var_800_4 and arg_797_1.time_ < 0 + var_800_4 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play1105006191 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1105006191
		arg_801_1.duration_ = 2.47

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play1105006192(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1.var_.moveOldPos1150ui_story = arg_801_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_804_0 = 0.001

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_0 then
				arg_801_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_801_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_801_1.time_ - 0) / var_804_0)
				arg_801_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_801_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_801_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_801_1.actors_["1150ui_story"].transform.position).z)
				arg_801_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_801_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_801_1.actors_["1150ui_story"].transform.localEulerAngles = arg_801_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_801_1.time_ >= 0 + var_804_0 and arg_801_1.time_ < 0 + var_804_0 + arg_804_0 then
				arg_801_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_801_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_801_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_801_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_801_1.actors_["1150ui_story"].transform.position).z)
				arg_801_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_801_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_801_1.actors_["1150ui_story"].transform.localEulerAngles = arg_801_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_804_1 = arg_801_1.actors_["1150ui_story"]

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 and not isNil(var_804_1) and arg_801_1.var_.characterEffect1150ui_story == nil then
				arg_801_1.var_.characterEffect1150ui_story = var_804_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_2 = 0.200000002980232

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_2 and not isNil(var_804_1) then
				if arg_801_1.var_.characterEffect1150ui_story and not isNil(var_804_1) then
					arg_801_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_801_1.time_ >= 0 + var_804_2 and arg_801_1.time_ < 0 + var_804_2 + arg_804_0 and not isNil(var_804_1) and arg_801_1.var_.characterEffect1150ui_story then
				arg_801_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_804_4 = 0
			local var_804_5 = 0.375

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= var_804_4 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				arg_801_1.leftNameTxt_.text = arg_801_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, false)
				arg_801_1.callingController_:SetSelectedState("normal")

				local var_804_6 = arg_801_1:GetWordFromCfg(1105006191)
				local var_804_7 = arg_801_1:FormatText(var_804_6.content)

				arg_801_1.text_.text = var_804_7

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_9 = 15 <= 0 and var_804_5 or var_804_5 * (utf8.len(var_804_7) / 15)

				if (15 <= 0 and var_804_5 or var_804_5 * (utf8.len(var_804_7) / 15)) > 0 and var_804_5 < var_804_9 then
					arg_801_1.talkMaxDuration = var_804_9

					if var_804_9 + var_804_4 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_9 + var_804_4
					end
				end

				arg_801_1.text_.text = var_804_7
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb") ~= 0 then
					local var_804_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb") / 1000

					if var_804_10 + var_804_4 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_10 + var_804_4
					end

					if var_804_6.prefab_name ~= "" and arg_801_1.actors_[var_804_6.prefab_name] ~= nil then
						local var_804_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_801_1.actors_[var_804_6.prefab_name].transform, "story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb")

						arg_801_1:RecordAudio("1105006191", var_804_11)
						arg_801_1:RecordAudio("1105006191", var_804_11)
					else
						arg_801_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb")
					end

					arg_801_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006191", "story_v_side_new_1105006.awb")
				end

				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_12 = math.max(var_804_5, arg_801_1.talkMaxDuration)

			if var_804_4 <= arg_801_1.time_ and arg_801_1.time_ < var_804_4 + var_804_12 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_4) / var_804_12

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_4 + var_804_12 and arg_801_1.time_ < var_804_4 + var_804_12 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_801_1:InitPlayNodeList()
	end,
	Play1105006192 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1105006192
		arg_805_1.duration_ = 5

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1105006193(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1.var_.moveOldPos1150ui_story = arg_805_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_808_0 = 0.001

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_0 then
				arg_805_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_805_1.time_ - 0) / var_808_0)
				arg_805_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1150ui_story"].transform.position).z)
				arg_805_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["1150ui_story"].transform.localEulerAngles = arg_805_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_805_1.time_ >= 0 + var_808_0 and arg_805_1.time_ < 0 + var_808_0 + arg_808_0 then
				arg_805_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_805_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["1150ui_story"].transform.position).z)
				arg_805_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["1150ui_story"].transform.localEulerAngles = arg_805_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_808_1 = 0
			local var_808_2 = 0.85

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_1 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				arg_805_1.leftNameTxt_.text = arg_805_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, true)
				arg_805_1.iconController_:SetSelectedState("hero")

				arg_805_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_805_1.callingController_:SetSelectedState("normal")

				arg_805_1.keyicon_.color = Color.New(1, 1, 1)
				arg_805_1.icon_.color = Color.New(1, 1, 1)

				local var_808_3 = arg_805_1:FormatText(arg_805_1:GetWordFromCfg(1105006192).content)

				arg_805_1.text_.text = var_808_3

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_5 = 34 <= 0 and var_808_2 or var_808_2 * (utf8.len(var_808_3) / 34)

				if (34 <= 0 and var_808_2 or var_808_2 * (utf8.len(var_808_3) / 34)) > 0 and var_808_2 < var_808_5 then
					arg_805_1.talkMaxDuration = var_808_5

					if var_808_5 + var_808_1 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_5 + var_808_1
					end
				end

				arg_805_1.text_.text = var_808_3
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)
				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_6 = math.max(var_808_2, arg_805_1.talkMaxDuration)

			if var_808_1 <= arg_805_1.time_ and arg_805_1.time_ < var_808_1 + var_808_6 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_1) / var_808_6

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_1 + var_808_6 and arg_805_1.time_ < var_808_1 + var_808_6 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_805_1:InitPlayNodeList()
	end,
	Play1105006193 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1105006193
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1105006194(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = 0.95

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				arg_809_1.leftNameTxt_.text = arg_809_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, true)
				arg_809_1.iconController_:SetSelectedState("hero")

				arg_809_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_809_1.callingController_:SetSelectedState("normal")

				arg_809_1.keyicon_.color = Color.New(1, 1, 1)
				arg_809_1.icon_.color = Color.New(1, 1, 1)

				local var_812_1 = arg_809_1:FormatText(arg_809_1:GetWordFromCfg(1105006193).content)

				arg_809_1.text_.text = var_812_1

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_3 = 38 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 38)

				if (38 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 38)) > 0 and var_812_0 < var_812_3 then
					arg_809_1.talkMaxDuration = var_812_3

					if var_812_3 + 0 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_3 + 0
					end
				end

				arg_809_1.text_.text = var_812_1
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_4 = math.max(var_812_0, arg_809_1.talkMaxDuration)

			if 0 <= arg_809_1.time_ and arg_809_1.time_ < 0 + var_812_4 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - 0) / var_812_4

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= 0 + var_812_4 and arg_809_1.time_ < 0 + var_812_4 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play1105006194 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1105006194
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1105006195(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			local var_816_0 = 0.95

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				arg_813_1.leftNameTxt_.text = arg_813_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, true)
				arg_813_1.iconController_:SetSelectedState("hero")

				arg_813_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_813_1.callingController_:SetSelectedState("normal")

				arg_813_1.keyicon_.color = Color.New(1, 1, 1)
				arg_813_1.icon_.color = Color.New(1, 1, 1)

				local var_816_1 = arg_813_1:FormatText(arg_813_1:GetWordFromCfg(1105006194).content)

				arg_813_1.text_.text = var_816_1

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_3 = 38 <= 0 and var_816_0 or var_816_0 * (utf8.len(var_816_1) / 38)

				if (38 <= 0 and var_816_0 or var_816_0 * (utf8.len(var_816_1) / 38)) > 0 and var_816_0 < var_816_3 then
					arg_813_1.talkMaxDuration = var_816_3

					if var_816_3 + 0 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_3 + 0
					end
				end

				arg_813_1.text_.text = var_816_1
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_4 = math.max(var_816_0, arg_813_1.talkMaxDuration)

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_4 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - 0) / var_816_4

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= 0 + var_816_4 and arg_813_1.time_ < 0 + var_816_4 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	Play1105006195 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 1105006195
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play1105006196(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			local var_820_0 = 1.275

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, false)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_817_1.iconTrs_.gameObject, false)
				arg_817_1.callingController_:SetSelectedState("normal")

				local var_820_1 = arg_817_1:FormatText(arg_817_1:GetWordFromCfg(1105006195).content)

				arg_817_1.text_.text = var_820_1

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_3 = 51 <= 0 and var_820_0 or var_820_0 * (utf8.len(var_820_1) / 51)

				if (51 <= 0 and var_820_0 or var_820_0 * (utf8.len(var_820_1) / 51)) > 0 and var_820_0 < var_820_3 then
					arg_817_1.talkMaxDuration = var_820_3

					if var_820_3 + 0 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_3 + 0
					end
				end

				arg_817_1.text_.text = var_820_1
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_4 = math.max(var_820_0, arg_817_1.talkMaxDuration)

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_4 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - 0) / var_820_4

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= 0 + var_820_4 and arg_817_1.time_ < 0 + var_820_4 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {}

		arg_817_1:InitPlayNodeList()
	end,
	Play1105006196 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 1105006196
		arg_821_1.duration_ = 5

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play1105006197(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			local var_824_0 = 0.15

			if 0 < arg_821_1.time_ and arg_821_1.time_ <= 0 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, true)

				arg_821_1.leftNameTxt_.text = arg_821_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, true)
				arg_821_1.iconController_:SetSelectedState("hero")

				arg_821_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_821_1.callingController_:SetSelectedState("normal")

				arg_821_1.keyicon_.color = Color.New(1, 1, 1)
				arg_821_1.icon_.color = Color.New(1, 1, 1)

				local var_824_1 = arg_821_1:FormatText(arg_821_1:GetWordFromCfg(1105006196).content)

				arg_821_1.text_.text = var_824_1

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_3 = 6 <= 0 and var_824_0 or var_824_0 * (utf8.len(var_824_1) / 6)

				if (6 <= 0 and var_824_0 or var_824_0 * (utf8.len(var_824_1) / 6)) > 0 and var_824_0 < var_824_3 then
					arg_821_1.talkMaxDuration = var_824_3

					if var_824_3 + 0 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_3 + 0
					end
				end

				arg_821_1.text_.text = var_824_1
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)
				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_4 = math.max(var_824_0, arg_821_1.talkMaxDuration)

			if 0 <= arg_821_1.time_ and arg_821_1.time_ < 0 + var_824_4 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - 0) / var_824_4

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= 0 + var_824_4 and arg_821_1.time_ < 0 + var_824_4 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {}

		arg_821_1:InitPlayNodeList()
	end,
	Play1105006197 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 1105006197
		arg_825_1.duration_ = 10.37

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play1105006198(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 then
				arg_825_1.var_.moveOldPos1150ui_story = arg_825_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_828_0 = 0.001

			if 0 <= arg_825_1.time_ and arg_825_1.time_ < 0 + var_828_0 then
				arg_825_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_825_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_825_1.time_ - 0) / var_828_0)
				arg_825_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_825_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["1150ui_story"].transform.position).z)
				arg_825_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_825_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_825_1.actors_["1150ui_story"].transform.localEulerAngles = arg_825_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_825_1.time_ >= 0 + var_828_0 and arg_825_1.time_ < 0 + var_828_0 + arg_828_0 then
				arg_825_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_825_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_825_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["1150ui_story"].transform.position).z)
				arg_825_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_825_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_825_1.actors_["1150ui_story"].transform.localEulerAngles = arg_825_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_828_1 = arg_825_1.actors_["1150ui_story"]

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 and not isNil(var_828_1) and arg_825_1.var_.characterEffect1150ui_story == nil then
				arg_825_1.var_.characterEffect1150ui_story = var_828_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_828_2 = 0.200000002980232

			if 0 <= arg_825_1.time_ and arg_825_1.time_ < 0 + var_828_2 and not isNil(var_828_1) then
				if arg_825_1.var_.characterEffect1150ui_story and not isNil(var_828_1) then
					arg_825_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_825_1.time_ >= 0 + var_828_2 and arg_825_1.time_ < 0 + var_828_2 + arg_828_0 and not isNil(var_828_1) and arg_825_1.var_.characterEffect1150ui_story then
				arg_825_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 then
				arg_825_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 then
				arg_825_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_828_4 = 0
			local var_828_5 = 0.825

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= var_828_4 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, true)

				arg_825_1.leftNameTxt_.text = arg_825_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_825_1.leftNameTxt_.transform)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1.leftNameTxt_.text)
				SetActive(arg_825_1.iconTrs_.gameObject, false)
				arg_825_1.callingController_:SetSelectedState("normal")

				local var_828_6 = arg_825_1:GetWordFromCfg(1105006197)
				local var_828_7 = arg_825_1:FormatText(var_828_6.content)

				arg_825_1.text_.text = var_828_7

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_9 = 33 <= 0 and var_828_5 or var_828_5 * (utf8.len(var_828_7) / 33)

				if (33 <= 0 and var_828_5 or var_828_5 * (utf8.len(var_828_7) / 33)) > 0 and var_828_5 < var_828_9 then
					arg_825_1.talkMaxDuration = var_828_9

					if var_828_9 + var_828_4 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_9 + var_828_4
					end
				end

				arg_825_1.text_.text = var_828_7
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb") ~= 0 then
					local var_828_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb") / 1000

					if var_828_10 + var_828_4 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_10 + var_828_4
					end

					if var_828_6.prefab_name ~= "" and arg_825_1.actors_[var_828_6.prefab_name] ~= nil then
						local var_828_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_825_1.actors_[var_828_6.prefab_name].transform, "story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb")

						arg_825_1:RecordAudio("1105006197", var_828_11)
						arg_825_1:RecordAudio("1105006197", var_828_11)
					else
						arg_825_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb")
					end

					arg_825_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006197", "story_v_side_new_1105006.awb")
				end

				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_12 = math.max(var_828_5, arg_825_1.talkMaxDuration)

			if var_828_4 <= arg_825_1.time_ and arg_825_1.time_ < var_828_4 + var_828_12 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - var_828_4) / var_828_12

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= var_828_4 + var_828_12 and arg_825_1.time_ < var_828_4 + var_828_12 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_825_1:InitPlayNodeList()
	end,
	Play1105006198 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 1105006198
		arg_829_1.duration_ = 5

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
		end

		function arg_829_1.playNext_(arg_831_0)
			if arg_831_0 == 1 then
				arg_829_0:Play1105006199(arg_829_1)
			end
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 and not isNil(arg_829_1.actors_["1150ui_story"]) and arg_829_1.var_.characterEffect1150ui_story == nil then
				arg_829_1.var_.characterEffect1150ui_story = arg_829_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_832_0 = 0.200000002980232

			if 0 <= arg_829_1.time_ and arg_829_1.time_ < 0 + var_832_0 and not isNil(arg_829_1.actors_["1150ui_story"]) then
				if arg_829_1.var_.characterEffect1150ui_story and not isNil(arg_829_1.actors_["1150ui_story"]) then
					arg_829_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_829_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_829_1.time_ - 0) / var_832_0)
				end
			end

			if arg_829_1.time_ >= 0 + var_832_0 and arg_829_1.time_ < 0 + var_832_0 + arg_832_0 and not isNil(arg_829_1.actors_["1150ui_story"]) and arg_829_1.var_.characterEffect1150ui_story then
				arg_829_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_829_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_832_1 = 0
			local var_832_2 = 0.05

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= var_832_1 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, true)

				arg_829_1.leftNameTxt_.text = arg_829_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_829_1.leftNameTxt_.transform)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1.leftNameTxt_.text)
				SetActive(arg_829_1.iconTrs_.gameObject, true)
				arg_829_1.iconController_:SetSelectedState("hero")

				arg_829_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_829_1.callingController_:SetSelectedState("normal")

				arg_829_1.keyicon_.color = Color.New(1, 1, 1)
				arg_829_1.icon_.color = Color.New(1, 1, 1)

				local var_832_3 = arg_829_1:FormatText(arg_829_1:GetWordFromCfg(1105006198).content)

				arg_829_1.text_.text = var_832_3

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_5 = 2 <= 0 and var_832_2 or var_832_2 * (utf8.len(var_832_3) / 2)

				if (2 <= 0 and var_832_2 or var_832_2 * (utf8.len(var_832_3) / 2)) > 0 and var_832_2 < var_832_5 then
					arg_829_1.talkMaxDuration = var_832_5

					if var_832_5 + var_832_1 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_5 + var_832_1
					end
				end

				arg_829_1.text_.text = var_832_3
				arg_829_1.typewritter.percent = 0

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(false)
				arg_829_1:RecordContent(arg_829_1.text_.text)
			end

			local var_832_6 = math.max(var_832_2, arg_829_1.talkMaxDuration)

			if var_832_1 <= arg_829_1.time_ and arg_829_1.time_ < var_832_1 + var_832_6 then
				arg_829_1.typewritter.percent = (arg_829_1.time_ - var_832_1) / var_832_6

				arg_829_1.typewritter:SetDirty()
			end

			if arg_829_1.time_ >= var_832_1 + var_832_6 and arg_829_1.time_ < var_832_1 + var_832_6 + arg_832_0 then
				arg_829_1.typewritter.percent = 1

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(true)
			end
		end

		arg_829_1.nodeConfigList_ = {}

		arg_829_1:InitPlayNodeList()
	end,
	Play1105006199 = function(arg_833_0, arg_833_1)
		arg_833_1.time_ = 0
		arg_833_1.frameCnt_ = 0
		arg_833_1.state_ = "playing"
		arg_833_1.curTalkId_ = 1105006199
		arg_833_1.duration_ = 5

		SetActive(arg_833_1.tipsGo_, false)

		function arg_833_1.onSingleLineFinish_()
			arg_833_1.onSingleLineUpdate_ = nil
			arg_833_1.onSingleLineFinish_ = nil
			arg_833_1.state_ = "waiting"
		end

		function arg_833_1.playNext_(arg_835_0)
			if arg_835_0 == 1 then
				arg_833_0:Play1105006200(arg_833_1)
			end
		end

		function arg_833_1.onSingleLineUpdate_(arg_836_0)
			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1.var_.moveOldPos1150ui_story = arg_833_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_836_0 = 0.001

			if 0 <= arg_833_1.time_ and arg_833_1.time_ < 0 + var_836_0 then
				arg_833_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_833_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_833_1.time_ - 0) / var_836_0)
				arg_833_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_833_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1150ui_story"].transform.position).z)
				arg_833_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_833_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_833_1.actors_["1150ui_story"].transform.localEulerAngles = arg_833_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_833_1.time_ >= 0 + var_836_0 and arg_833_1.time_ < 0 + var_836_0 + arg_836_0 then
				arg_833_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_833_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_833_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1150ui_story"].transform.position).z)
				arg_833_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_833_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_833_1.actors_["1150ui_story"].transform.localEulerAngles = arg_833_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_836_1 = 0
			local var_836_2 = 0.925

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= var_836_1 + arg_836_0 then
				arg_833_1.talkMaxDuration = 0
				arg_833_1.dialogCg_.alpha = 1

				arg_833_1.dialog_:SetActive(true)
				SetActive(arg_833_1.leftNameGo_, false)

				arg_833_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_833_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_833_1:RecordName(arg_833_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_833_1.iconTrs_.gameObject, false)
				arg_833_1.callingController_:SetSelectedState("normal")

				local var_836_3 = arg_833_1:FormatText(arg_833_1:GetWordFromCfg(1105006199).content)

				arg_833_1.text_.text = var_836_3

				LuaForUtil.ClearLinePrefixSymbol(arg_833_1.text_)

				local var_836_5 = 37 <= 0 and var_836_2 or var_836_2 * (utf8.len(var_836_3) / 37)

				if (37 <= 0 and var_836_2 or var_836_2 * (utf8.len(var_836_3) / 37)) > 0 and var_836_2 < var_836_5 then
					arg_833_1.talkMaxDuration = var_836_5

					if var_836_5 + var_836_1 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_5 + var_836_1
					end
				end

				arg_833_1.text_.text = var_836_3
				arg_833_1.typewritter.percent = 0

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(false)
				arg_833_1:RecordContent(arg_833_1.text_.text)
			end

			local var_836_6 = math.max(var_836_2, arg_833_1.talkMaxDuration)

			if var_836_1 <= arg_833_1.time_ and arg_833_1.time_ < var_836_1 + var_836_6 then
				arg_833_1.typewritter.percent = (arg_833_1.time_ - var_836_1) / var_836_6

				arg_833_1.typewritter:SetDirty()
			end

			if arg_833_1.time_ >= var_836_1 + var_836_6 and arg_833_1.time_ < var_836_1 + var_836_6 + arg_836_0 then
				arg_833_1.typewritter.percent = 1

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(true)
			end
		end

		arg_833_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_833_1:InitPlayNodeList()
	end,
	Play1105006200 = function(arg_837_0, arg_837_1)
		arg_837_1.time_ = 0
		arg_837_1.frameCnt_ = 0
		arg_837_1.state_ = "playing"
		arg_837_1.curTalkId_ = 1105006200
		arg_837_1.duration_ = 5

		SetActive(arg_837_1.tipsGo_, false)

		function arg_837_1.onSingleLineFinish_()
			arg_837_1.onSingleLineUpdate_ = nil
			arg_837_1.onSingleLineFinish_ = nil
			arg_837_1.state_ = "waiting"
		end

		function arg_837_1.playNext_(arg_839_0)
			if arg_839_0 == 1 then
				arg_837_0:Play1105006201(arg_837_1)
			end
		end

		function arg_837_1.onSingleLineUpdate_(arg_840_0)
			local var_840_0 = 0.625

			if 0 < arg_837_1.time_ and arg_837_1.time_ <= 0 + arg_840_0 then
				arg_837_1.talkMaxDuration = 0
				arg_837_1.dialogCg_.alpha = 1

				arg_837_1.dialog_:SetActive(true)
				SetActive(arg_837_1.leftNameGo_, false)

				arg_837_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_837_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_837_1:RecordName(arg_837_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_837_1.iconTrs_.gameObject, false)
				arg_837_1.callingController_:SetSelectedState("normal")

				local var_840_1 = arg_837_1:FormatText(arg_837_1:GetWordFromCfg(1105006200).content)

				arg_837_1.text_.text = var_840_1

				LuaForUtil.ClearLinePrefixSymbol(arg_837_1.text_)

				local var_840_3 = 25 <= 0 and var_840_0 or var_840_0 * (utf8.len(var_840_1) / 25)

				if (25 <= 0 and var_840_0 or var_840_0 * (utf8.len(var_840_1) / 25)) > 0 and var_840_0 < var_840_3 then
					arg_837_1.talkMaxDuration = var_840_3

					if var_840_3 + 0 > arg_837_1.duration_ then
						arg_837_1.duration_ = var_840_3 + 0
					end
				end

				arg_837_1.text_.text = var_840_1
				arg_837_1.typewritter.percent = 0

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(false)
				arg_837_1:RecordContent(arg_837_1.text_.text)
			end

			local var_840_4 = math.max(var_840_0, arg_837_1.talkMaxDuration)

			if 0 <= arg_837_1.time_ and arg_837_1.time_ < 0 + var_840_4 then
				arg_837_1.typewritter.percent = (arg_837_1.time_ - 0) / var_840_4

				arg_837_1.typewritter:SetDirty()
			end

			if arg_837_1.time_ >= 0 + var_840_4 and arg_837_1.time_ < 0 + var_840_4 + arg_840_0 then
				arg_837_1.typewritter.percent = 1

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(true)
			end
		end

		arg_837_1.nodeConfigList_ = {}

		arg_837_1:InitPlayNodeList()
	end,
	Play1105006201 = function(arg_841_0, arg_841_1)
		arg_841_1.time_ = 0
		arg_841_1.frameCnt_ = 0
		arg_841_1.state_ = "playing"
		arg_841_1.curTalkId_ = 1105006201
		arg_841_1.duration_ = 6.33

		SetActive(arg_841_1.tipsGo_, false)

		function arg_841_1.onSingleLineFinish_()
			arg_841_1.onSingleLineUpdate_ = nil
			arg_841_1.onSingleLineFinish_ = nil
			arg_841_1.state_ = "waiting"
		end

		function arg_841_1.playNext_(arg_843_0)
			if arg_843_0 == 1 then
				arg_841_0:Play1105006202(arg_841_1)
			end
		end

		function arg_841_1.onSingleLineUpdate_(arg_844_0)
			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 then
				arg_841_1.var_.moveOldPos1150ui_story = arg_841_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_844_0 = 0.001

			if 0 <= arg_841_1.time_ and arg_841_1.time_ < 0 + var_844_0 then
				arg_841_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_841_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_841_1.time_ - 0) / var_844_0)
				arg_841_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_841_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1150ui_story"].transform.position).z)
				arg_841_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_841_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_841_1.actors_["1150ui_story"].transform.localEulerAngles = arg_841_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_841_1.time_ >= 0 + var_844_0 and arg_841_1.time_ < 0 + var_844_0 + arg_844_0 then
				arg_841_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_841_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_841_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1150ui_story"].transform.position).z)
				arg_841_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_841_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_841_1.actors_["1150ui_story"].transform.localEulerAngles = arg_841_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_844_1 = arg_841_1.actors_["1150ui_story"]

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 and not isNil(var_844_1) and arg_841_1.var_.characterEffect1150ui_story == nil then
				arg_841_1.var_.characterEffect1150ui_story = var_844_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_844_2 = 0.200000002980232

			if 0 <= arg_841_1.time_ and arg_841_1.time_ < 0 + var_844_2 and not isNil(var_844_1) then
				if arg_841_1.var_.characterEffect1150ui_story and not isNil(var_844_1) then
					arg_841_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_841_1.time_ >= 0 + var_844_2 and arg_841_1.time_ < 0 + var_844_2 + arg_844_0 and not isNil(var_844_1) and arg_841_1.var_.characterEffect1150ui_story then
				arg_841_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 then
				arg_841_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 then
				arg_841_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_844_4 = 0
			local var_844_5 = 0.65

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= var_844_4 + arg_844_0 then
				arg_841_1.talkMaxDuration = 0
				arg_841_1.dialogCg_.alpha = 1

				arg_841_1.dialog_:SetActive(true)
				SetActive(arg_841_1.leftNameGo_, true)

				arg_841_1.leftNameTxt_.text = arg_841_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_841_1.leftNameTxt_.transform)

				arg_841_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_841_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_841_1:RecordName(arg_841_1.leftNameTxt_.text)
				SetActive(arg_841_1.iconTrs_.gameObject, false)
				arg_841_1.callingController_:SetSelectedState("normal")

				local var_844_6 = arg_841_1:GetWordFromCfg(1105006201)
				local var_844_7 = arg_841_1:FormatText(var_844_6.content)

				arg_841_1.text_.text = var_844_7

				LuaForUtil.ClearLinePrefixSymbol(arg_841_1.text_)

				local var_844_9 = 26 <= 0 and var_844_5 or var_844_5 * (utf8.len(var_844_7) / 26)

				if (26 <= 0 and var_844_5 or var_844_5 * (utf8.len(var_844_7) / 26)) > 0 and var_844_5 < var_844_9 then
					arg_841_1.talkMaxDuration = var_844_9

					if var_844_9 + var_844_4 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_9 + var_844_4
					end
				end

				arg_841_1.text_.text = var_844_7
				arg_841_1.typewritter.percent = 0

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb") ~= 0 then
					local var_844_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb") / 1000

					if var_844_10 + var_844_4 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_10 + var_844_4
					end

					if var_844_6.prefab_name ~= "" and arg_841_1.actors_[var_844_6.prefab_name] ~= nil then
						local var_844_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_841_1.actors_[var_844_6.prefab_name].transform, "story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb")

						arg_841_1:RecordAudio("1105006201", var_844_11)
						arg_841_1:RecordAudio("1105006201", var_844_11)
					else
						arg_841_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb")
					end

					arg_841_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006201", "story_v_side_new_1105006.awb")
				end

				arg_841_1:RecordContent(arg_841_1.text_.text)
			end

			local var_844_12 = math.max(var_844_5, arg_841_1.talkMaxDuration)

			if var_844_4 <= arg_841_1.time_ and arg_841_1.time_ < var_844_4 + var_844_12 then
				arg_841_1.typewritter.percent = (arg_841_1.time_ - var_844_4) / var_844_12

				arg_841_1.typewritter:SetDirty()
			end

			if arg_841_1.time_ >= var_844_4 + var_844_12 and arg_841_1.time_ < var_844_4 + var_844_12 + arg_844_0 then
				arg_841_1.typewritter.percent = 1

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(true)
			end
		end

		arg_841_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_841_1:InitPlayNodeList()
	end,
	Play1105006202 = function(arg_845_0, arg_845_1)
		arg_845_1.time_ = 0
		arg_845_1.frameCnt_ = 0
		arg_845_1.state_ = "playing"
		arg_845_1.curTalkId_ = 1105006202
		arg_845_1.duration_ = 5.4

		SetActive(arg_845_1.tipsGo_, false)

		function arg_845_1.onSingleLineFinish_()
			arg_845_1.onSingleLineUpdate_ = nil
			arg_845_1.onSingleLineFinish_ = nil
			arg_845_1.state_ = "waiting"
		end

		function arg_845_1.playNext_(arg_847_0)
			if arg_847_0 == 1 then
				arg_845_0:Play1105006203(arg_845_1)
			end
		end

		function arg_845_1.onSingleLineUpdate_(arg_848_0)
			local var_848_0 = 0.6

			if 0 < arg_845_1.time_ and arg_845_1.time_ <= 0 + arg_848_0 then
				arg_845_1.talkMaxDuration = 0
				arg_845_1.dialogCg_.alpha = 1

				arg_845_1.dialog_:SetActive(true)
				SetActive(arg_845_1.leftNameGo_, true)

				arg_845_1.leftNameTxt_.text = arg_845_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_845_1.leftNameTxt_.transform)

				arg_845_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_845_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_845_1:RecordName(arg_845_1.leftNameTxt_.text)
				SetActive(arg_845_1.iconTrs_.gameObject, false)
				arg_845_1.callingController_:SetSelectedState("normal")

				local var_848_1 = arg_845_1:GetWordFromCfg(1105006202)
				local var_848_2 = arg_845_1:FormatText(var_848_1.content)

				arg_845_1.text_.text = var_848_2

				LuaForUtil.ClearLinePrefixSymbol(arg_845_1.text_)

				local var_848_4 = 24 <= 0 and var_848_0 or var_848_0 * (utf8.len(var_848_2) / 24)

				if (24 <= 0 and var_848_0 or var_848_0 * (utf8.len(var_848_2) / 24)) > 0 and var_848_0 < var_848_4 then
					arg_845_1.talkMaxDuration = var_848_4

					if var_848_4 + 0 > arg_845_1.duration_ then
						arg_845_1.duration_ = var_848_4 + 0
					end
				end

				arg_845_1.text_.text = var_848_2
				arg_845_1.typewritter.percent = 0

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb") ~= 0 then
					local var_848_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb") / 1000

					if var_848_5 + 0 > arg_845_1.duration_ then
						arg_845_1.duration_ = var_848_5 + 0
					end

					if var_848_1.prefab_name ~= "" and arg_845_1.actors_[var_848_1.prefab_name] ~= nil then
						local var_848_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_845_1.actors_[var_848_1.prefab_name].transform, "story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb")

						arg_845_1:RecordAudio("1105006202", var_848_6)
						arg_845_1:RecordAudio("1105006202", var_848_6)
					else
						arg_845_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb")
					end

					arg_845_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006202", "story_v_side_new_1105006.awb")
				end

				arg_845_1:RecordContent(arg_845_1.text_.text)
			end

			local var_848_7 = math.max(var_848_0, arg_845_1.talkMaxDuration)

			if 0 <= arg_845_1.time_ and arg_845_1.time_ < 0 + var_848_7 then
				arg_845_1.typewritter.percent = (arg_845_1.time_ - 0) / var_848_7

				arg_845_1.typewritter:SetDirty()
			end

			if arg_845_1.time_ >= 0 + var_848_7 and arg_845_1.time_ < 0 + var_848_7 + arg_848_0 then
				arg_845_1.typewritter.percent = 1

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(true)
			end
		end

		arg_845_1.nodeConfigList_ = {}

		arg_845_1:InitPlayNodeList()
	end,
	Play1105006203 = function(arg_849_0, arg_849_1)
		arg_849_1.time_ = 0
		arg_849_1.frameCnt_ = 0
		arg_849_1.state_ = "playing"
		arg_849_1.curTalkId_ = 1105006203
		arg_849_1.duration_ = 3

		SetActive(arg_849_1.tipsGo_, false)

		function arg_849_1.onSingleLineFinish_()
			arg_849_1.onSingleLineUpdate_ = nil
			arg_849_1.onSingleLineFinish_ = nil
			arg_849_1.state_ = "waiting"
		end

		function arg_849_1.playNext_(arg_851_0)
			if arg_851_0 == 1 then
				arg_849_0:Play1105006204(arg_849_1)
			end
		end

		function arg_849_1.onSingleLineUpdate_(arg_852_0)
			local var_852_0 = 0.3

			if 0 < arg_849_1.time_ and arg_849_1.time_ <= 0 + arg_852_0 then
				arg_849_1.talkMaxDuration = 0
				arg_849_1.dialogCg_.alpha = 1

				arg_849_1.dialog_:SetActive(true)
				SetActive(arg_849_1.leftNameGo_, true)

				arg_849_1.leftNameTxt_.text = arg_849_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_849_1.leftNameTxt_.transform)

				arg_849_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_849_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_849_1:RecordName(arg_849_1.leftNameTxt_.text)
				SetActive(arg_849_1.iconTrs_.gameObject, false)
				arg_849_1.callingController_:SetSelectedState("normal")

				local var_852_1 = arg_849_1:GetWordFromCfg(1105006203)
				local var_852_2 = arg_849_1:FormatText(var_852_1.content)

				arg_849_1.text_.text = var_852_2

				LuaForUtil.ClearLinePrefixSymbol(arg_849_1.text_)

				local var_852_4 = 12 <= 0 and var_852_0 or var_852_0 * (utf8.len(var_852_2) / 12)

				if (12 <= 0 and var_852_0 or var_852_0 * (utf8.len(var_852_2) / 12)) > 0 and var_852_0 < var_852_4 then
					arg_849_1.talkMaxDuration = var_852_4

					if var_852_4 + 0 > arg_849_1.duration_ then
						arg_849_1.duration_ = var_852_4 + 0
					end
				end

				arg_849_1.text_.text = var_852_2
				arg_849_1.typewritter.percent = 0

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb") ~= 0 then
					local var_852_5 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb") / 1000

					if var_852_5 + 0 > arg_849_1.duration_ then
						arg_849_1.duration_ = var_852_5 + 0
					end

					if var_852_1.prefab_name ~= "" and arg_849_1.actors_[var_852_1.prefab_name] ~= nil then
						local var_852_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_849_1.actors_[var_852_1.prefab_name].transform, "story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb")

						arg_849_1:RecordAudio("1105006203", var_852_6)
						arg_849_1:RecordAudio("1105006203", var_852_6)
					else
						arg_849_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb")
					end

					arg_849_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006203", "story_v_side_new_1105006.awb")
				end

				arg_849_1:RecordContent(arg_849_1.text_.text)
			end

			local var_852_7 = math.max(var_852_0, arg_849_1.talkMaxDuration)

			if 0 <= arg_849_1.time_ and arg_849_1.time_ < 0 + var_852_7 then
				arg_849_1.typewritter.percent = (arg_849_1.time_ - 0) / var_852_7

				arg_849_1.typewritter:SetDirty()
			end

			if arg_849_1.time_ >= 0 + var_852_7 and arg_849_1.time_ < 0 + var_852_7 + arg_852_0 then
				arg_849_1.typewritter.percent = 1

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(true)
			end
		end

		arg_849_1.nodeConfigList_ = {}

		arg_849_1:InitPlayNodeList()
	end,
	Play1105006204 = function(arg_853_0, arg_853_1)
		arg_853_1.time_ = 0
		arg_853_1.frameCnt_ = 0
		arg_853_1.state_ = "playing"
		arg_853_1.curTalkId_ = 1105006204
		arg_853_1.duration_ = 5

		SetActive(arg_853_1.tipsGo_, false)

		function arg_853_1.onSingleLineFinish_()
			arg_853_1.onSingleLineUpdate_ = nil
			arg_853_1.onSingleLineFinish_ = nil
			arg_853_1.state_ = "waiting"
		end

		function arg_853_1.playNext_(arg_855_0)
			if arg_855_0 == 1 then
				arg_853_0:Play1105006205(arg_853_1)
			end
		end

		function arg_853_1.onSingleLineUpdate_(arg_856_0)
			if 0 < arg_853_1.time_ and arg_853_1.time_ <= 0 + arg_856_0 and not isNil(arg_853_1.actors_["1150ui_story"]) and arg_853_1.var_.characterEffect1150ui_story == nil then
				arg_853_1.var_.characterEffect1150ui_story = arg_853_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_856_0 = 0.200000002980232

			if 0 <= arg_853_1.time_ and arg_853_1.time_ < 0 + var_856_0 and not isNil(arg_853_1.actors_["1150ui_story"]) then
				if arg_853_1.var_.characterEffect1150ui_story and not isNil(arg_853_1.actors_["1150ui_story"]) then
					arg_853_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_853_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_853_1.time_ - 0) / var_856_0)
				end
			end

			if arg_853_1.time_ >= 0 + var_856_0 and arg_853_1.time_ < 0 + var_856_0 + arg_856_0 and not isNil(arg_853_1.actors_["1150ui_story"]) and arg_853_1.var_.characterEffect1150ui_story then
				arg_853_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_853_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_856_1 = 0
			local var_856_2 = 1.15

			if 0 < arg_853_1.time_ and arg_853_1.time_ <= var_856_1 + arg_856_0 then
				arg_853_1.talkMaxDuration = 0
				arg_853_1.dialogCg_.alpha = 1

				arg_853_1.dialog_:SetActive(true)
				SetActive(arg_853_1.leftNameGo_, false)

				arg_853_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_853_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_853_1:RecordName(arg_853_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_853_1.iconTrs_.gameObject, false)
				arg_853_1.callingController_:SetSelectedState("normal")

				local var_856_3 = arg_853_1:FormatText(arg_853_1:GetWordFromCfg(1105006204).content)

				arg_853_1.text_.text = var_856_3

				LuaForUtil.ClearLinePrefixSymbol(arg_853_1.text_)

				local var_856_5 = 46 <= 0 and var_856_2 or var_856_2 * (utf8.len(var_856_3) / 46)

				if (46 <= 0 and var_856_2 or var_856_2 * (utf8.len(var_856_3) / 46)) > 0 and var_856_2 < var_856_5 then
					arg_853_1.talkMaxDuration = var_856_5

					if var_856_5 + var_856_1 > arg_853_1.duration_ then
						arg_853_1.duration_ = var_856_5 + var_856_1
					end
				end

				arg_853_1.text_.text = var_856_3
				arg_853_1.typewritter.percent = 0

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(false)
				arg_853_1:RecordContent(arg_853_1.text_.text)
			end

			local var_856_6 = math.max(var_856_2, arg_853_1.talkMaxDuration)

			if var_856_1 <= arg_853_1.time_ and arg_853_1.time_ < var_856_1 + var_856_6 then
				arg_853_1.typewritter.percent = (arg_853_1.time_ - var_856_1) / var_856_6

				arg_853_1.typewritter:SetDirty()
			end

			if arg_853_1.time_ >= var_856_1 + var_856_6 and arg_853_1.time_ < var_856_1 + var_856_6 + arg_856_0 then
				arg_853_1.typewritter.percent = 1

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(true)
			end
		end

		arg_853_1.nodeConfigList_ = {}

		arg_853_1:InitPlayNodeList()
	end,
	Play1105006205 = function(arg_857_0, arg_857_1)
		arg_857_1.time_ = 0
		arg_857_1.frameCnt_ = 0
		arg_857_1.state_ = "playing"
		arg_857_1.curTalkId_ = 1105006205
		arg_857_1.duration_ = 12.37

		SetActive(arg_857_1.tipsGo_, false)

		function arg_857_1.onSingleLineFinish_()
			arg_857_1.onSingleLineUpdate_ = nil
			arg_857_1.onSingleLineFinish_ = nil
			arg_857_1.state_ = "waiting"
		end

		function arg_857_1.playNext_(arg_859_0)
			if arg_859_0 == 1 then
				arg_857_0:Play1105006206(arg_857_1)
			end
		end

		function arg_857_1.onSingleLineUpdate_(arg_860_0)
			if 0 < arg_857_1.time_ and arg_857_1.time_ <= 0 + arg_860_0 and not isNil(arg_857_1.actors_["1150ui_story"]) and arg_857_1.var_.characterEffect1150ui_story == nil then
				arg_857_1.var_.characterEffect1150ui_story = arg_857_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_860_0 = 0.200000002980232

			if 0 <= arg_857_1.time_ and arg_857_1.time_ < 0 + var_860_0 and not isNil(arg_857_1.actors_["1150ui_story"]) then
				if arg_857_1.var_.characterEffect1150ui_story and not isNil(arg_857_1.actors_["1150ui_story"]) then
					arg_857_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_857_1.time_ >= 0 + var_860_0 and arg_857_1.time_ < 0 + var_860_0 + arg_860_0 and not isNil(arg_857_1.actors_["1150ui_story"]) and arg_857_1.var_.characterEffect1150ui_story then
				arg_857_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_857_1.time_ and arg_857_1.time_ <= 0 + arg_860_0 then
				arg_857_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_857_1.time_ and arg_857_1.time_ <= 0 + arg_860_0 then
				arg_857_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_860_2 = 0
			local var_860_3 = 1.175

			if 0 < arg_857_1.time_ and arg_857_1.time_ <= var_860_2 + arg_860_0 then
				arg_857_1.talkMaxDuration = 0
				arg_857_1.dialogCg_.alpha = 1

				arg_857_1.dialog_:SetActive(true)
				SetActive(arg_857_1.leftNameGo_, true)

				arg_857_1.leftNameTxt_.text = arg_857_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_857_1.leftNameTxt_.transform)

				arg_857_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_857_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_857_1:RecordName(arg_857_1.leftNameTxt_.text)
				SetActive(arg_857_1.iconTrs_.gameObject, false)
				arg_857_1.callingController_:SetSelectedState("normal")

				local var_860_4 = arg_857_1:GetWordFromCfg(1105006205)
				local var_860_5 = arg_857_1:FormatText(var_860_4.content)

				arg_857_1.text_.text = var_860_5

				LuaForUtil.ClearLinePrefixSymbol(arg_857_1.text_)

				local var_860_7 = 47 <= 0 and var_860_3 or var_860_3 * (utf8.len(var_860_5) / 47)

				if (47 <= 0 and var_860_3 or var_860_3 * (utf8.len(var_860_5) / 47)) > 0 and var_860_3 < var_860_7 then
					arg_857_1.talkMaxDuration = var_860_7

					if var_860_7 + var_860_2 > arg_857_1.duration_ then
						arg_857_1.duration_ = var_860_7 + var_860_2
					end
				end

				arg_857_1.text_.text = var_860_5
				arg_857_1.typewritter.percent = 0

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb") ~= 0 then
					local var_860_8 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb") / 1000

					if var_860_8 + var_860_2 > arg_857_1.duration_ then
						arg_857_1.duration_ = var_860_8 + var_860_2
					end

					if var_860_4.prefab_name ~= "" and arg_857_1.actors_[var_860_4.prefab_name] ~= nil then
						local var_860_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_857_1.actors_[var_860_4.prefab_name].transform, "story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb")

						arg_857_1:RecordAudio("1105006205", var_860_9)
						arg_857_1:RecordAudio("1105006205", var_860_9)
					else
						arg_857_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb")
					end

					arg_857_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006205", "story_v_side_new_1105006.awb")
				end

				arg_857_1:RecordContent(arg_857_1.text_.text)
			end

			local var_860_10 = math.max(var_860_3, arg_857_1.talkMaxDuration)

			if var_860_2 <= arg_857_1.time_ and arg_857_1.time_ < var_860_2 + var_860_10 then
				arg_857_1.typewritter.percent = (arg_857_1.time_ - var_860_2) / var_860_10

				arg_857_1.typewritter:SetDirty()
			end

			if arg_857_1.time_ >= var_860_2 + var_860_10 and arg_857_1.time_ < var_860_2 + var_860_10 + arg_860_0 then
				arg_857_1.typewritter.percent = 1

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(true)
			end
		end

		arg_857_1.nodeConfigList_ = {}

		arg_857_1:InitPlayNodeList()
	end,
	Play1105006206 = function(arg_861_0, arg_861_1)
		arg_861_1.time_ = 0
		arg_861_1.frameCnt_ = 0
		arg_861_1.state_ = "playing"
		arg_861_1.curTalkId_ = 1105006206
		arg_861_1.duration_ = 1

		SetActive(arg_861_1.tipsGo_, false)

		function arg_861_1.onSingleLineFinish_()
			arg_861_1.onSingleLineUpdate_ = nil
			arg_861_1.onSingleLineFinish_ = nil
			arg_861_1.state_ = "waiting"

			SetActive(arg_861_1.choicesGo_, true)

			for iter_862_0, iter_862_1 in ipairs(arg_861_1.choices_) do
				SetActive(iter_862_1.go, iter_862_0 <= 1)
			end

			arg_861_1.choices_[1].txt.text = arg_861_1:FormatText(StoryChoiceCfg[1070].name)
		end

		function arg_861_1.playNext_(arg_863_0)
			if arg_863_0 == 1 then
				arg_861_0:Play1105006207(arg_861_1)
			end

			arg_861_1:RecordChoiceLog(1105006206, 1070)
		end

		function arg_861_1.onSingleLineUpdate_(arg_864_0)
			if 0 < arg_861_1.time_ and arg_861_1.time_ <= 0 + arg_864_0 then
				arg_861_1.allBtn_.enabled = false
			end

			if arg_861_1.time_ >= 0 + 0.6 and arg_861_1.time_ < 0 + 0.6 + arg_864_0 then
				arg_861_1.allBtn_.enabled = true
			end
		end

		arg_861_1.nodeConfigList_ = {}

		arg_861_1:InitPlayNodeList()
	end,
	Play1105006207 = function(arg_865_0, arg_865_1)
		arg_865_1.time_ = 0
		arg_865_1.frameCnt_ = 0
		arg_865_1.state_ = "playing"
		arg_865_1.curTalkId_ = 1105006207
		arg_865_1.duration_ = 5

		SetActive(arg_865_1.tipsGo_, false)

		function arg_865_1.onSingleLineFinish_()
			arg_865_1.onSingleLineUpdate_ = nil
			arg_865_1.onSingleLineFinish_ = nil
			arg_865_1.state_ = "waiting"
		end

		function arg_865_1.playNext_(arg_867_0)
			if arg_867_0 == 1 then
				arg_865_0:Play1105006208(arg_865_1)
			end
		end

		function arg_865_1.onSingleLineUpdate_(arg_868_0)
			if 0 < arg_865_1.time_ and arg_865_1.time_ <= 0 + arg_868_0 then
				arg_865_1.var_.moveOldPos1150ui_story = arg_865_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_868_0 = 0.001

			if 0 <= arg_865_1.time_ and arg_865_1.time_ < 0 + var_868_0 then
				arg_865_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_865_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_865_1.time_ - 0) / var_868_0)
				arg_865_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_865_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1150ui_story"].transform.position).z)
				arg_865_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_865_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_865_1.actors_["1150ui_story"].transform.localEulerAngles = arg_865_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_865_1.time_ >= 0 + var_868_0 and arg_865_1.time_ < 0 + var_868_0 + arg_868_0 then
				arg_865_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_865_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_865_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_865_1.actors_["1150ui_story"].transform.position).z)
				arg_865_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_865_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_865_1.actors_["1150ui_story"].transform.localEulerAngles = arg_865_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_868_1 = 0
			local var_868_2 = 0.675

			if 0 < arg_865_1.time_ and arg_865_1.time_ <= var_868_1 + arg_868_0 then
				arg_865_1.talkMaxDuration = 0
				arg_865_1.dialogCg_.alpha = 1

				arg_865_1.dialog_:SetActive(true)
				SetActive(arg_865_1.leftNameGo_, false)

				arg_865_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_865_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_865_1:RecordName(arg_865_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_865_1.iconTrs_.gameObject, false)
				arg_865_1.callingController_:SetSelectedState("normal")

				local var_868_3 = arg_865_1:FormatText(arg_865_1:GetWordFromCfg(1105006207).content)

				arg_865_1.text_.text = var_868_3

				LuaForUtil.ClearLinePrefixSymbol(arg_865_1.text_)

				local var_868_5 = 27 <= 0 and var_868_2 or var_868_2 * (utf8.len(var_868_3) / 27)

				if (27 <= 0 and var_868_2 or var_868_2 * (utf8.len(var_868_3) / 27)) > 0 and var_868_2 < var_868_5 then
					arg_865_1.talkMaxDuration = var_868_5

					if var_868_5 + var_868_1 > arg_865_1.duration_ then
						arg_865_1.duration_ = var_868_5 + var_868_1
					end
				end

				arg_865_1.text_.text = var_868_3
				arg_865_1.typewritter.percent = 0

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(false)
				arg_865_1:RecordContent(arg_865_1.text_.text)
			end

			local var_868_6 = math.max(var_868_2, arg_865_1.talkMaxDuration)

			if var_868_1 <= arg_865_1.time_ and arg_865_1.time_ < var_868_1 + var_868_6 then
				arg_865_1.typewritter.percent = (arg_865_1.time_ - var_868_1) / var_868_6

				arg_865_1.typewritter:SetDirty()
			end

			if arg_865_1.time_ >= var_868_1 + var_868_6 and arg_865_1.time_ < var_868_1 + var_868_6 + arg_868_0 then
				arg_865_1.typewritter.percent = 1

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(true)
			end
		end

		arg_865_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_865_1:InitPlayNodeList()
	end,
	Play1105006208 = function(arg_869_0, arg_869_1)
		arg_869_1.time_ = 0
		arg_869_1.frameCnt_ = 0
		arg_869_1.state_ = "playing"
		arg_869_1.curTalkId_ = 1105006208
		arg_869_1.duration_ = 5.13

		SetActive(arg_869_1.tipsGo_, false)

		function arg_869_1.onSingleLineFinish_()
			arg_869_1.onSingleLineUpdate_ = nil
			arg_869_1.onSingleLineFinish_ = nil
			arg_869_1.state_ = "waiting"
			arg_869_1.auto_ = false
		end

		function arg_869_1.playNext_(arg_871_0)
			arg_869_1.onStoryFinished_()
		end

		function arg_869_1.onSingleLineUpdate_(arg_872_0)
			if 0 < arg_869_1.time_ and arg_869_1.time_ <= 0 + arg_872_0 then
				arg_869_1.var_.moveOldPos1150ui_story = arg_869_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_872_0 = 0.001

			if 0 <= arg_869_1.time_ and arg_869_1.time_ < 0 + var_872_0 then
				arg_869_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_869_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_869_1.time_ - 0) / var_872_0)
				arg_869_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_869_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_869_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_869_1.actors_["1150ui_story"].transform.position).z)
				arg_869_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_869_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_869_1.actors_["1150ui_story"].transform.localEulerAngles = arg_869_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_869_1.time_ >= 0 + var_872_0 and arg_869_1.time_ < 0 + var_872_0 + arg_872_0 then
				arg_869_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_869_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_869_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_869_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_869_1.actors_["1150ui_story"].transform.position).z)
				arg_869_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_869_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_869_1.actors_["1150ui_story"].transform.localEulerAngles = arg_869_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_872_1 = arg_869_1.actors_["1150ui_story"]

			if 0 < arg_869_1.time_ and arg_869_1.time_ <= 0 + arg_872_0 and not isNil(var_872_1) and arg_869_1.var_.characterEffect1150ui_story == nil then
				arg_869_1.var_.characterEffect1150ui_story = var_872_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_872_2 = 0.200000002980232

			if 0 <= arg_869_1.time_ and arg_869_1.time_ < 0 + var_872_2 and not isNil(var_872_1) then
				if arg_869_1.var_.characterEffect1150ui_story and not isNil(var_872_1) then
					arg_869_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_869_1.time_ >= 0 + var_872_2 and arg_869_1.time_ < 0 + var_872_2 + arg_872_0 and not isNil(var_872_1) and arg_869_1.var_.characterEffect1150ui_story then
				arg_869_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_869_1.time_ and arg_869_1.time_ <= 0 + arg_872_0 then
				arg_869_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_869_1.time_ and arg_869_1.time_ <= 0 + arg_872_0 then
				arg_869_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_872_4 = 0
			local var_872_5 = 0.45

			if 0 < arg_869_1.time_ and arg_869_1.time_ <= var_872_4 + arg_872_0 then
				arg_869_1.talkMaxDuration = 0
				arg_869_1.dialogCg_.alpha = 1

				arg_869_1.dialog_:SetActive(true)
				SetActive(arg_869_1.leftNameGo_, true)

				arg_869_1.leftNameTxt_.text = arg_869_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_869_1.leftNameTxt_.transform)

				arg_869_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_869_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_869_1:RecordName(arg_869_1.leftNameTxt_.text)
				SetActive(arg_869_1.iconTrs_.gameObject, false)
				arg_869_1.callingController_:SetSelectedState("normal")

				local var_872_6 = arg_869_1:GetWordFromCfg(1105006208)
				local var_872_7 = arg_869_1:FormatText(var_872_6.content)

				arg_869_1.text_.text = var_872_7

				LuaForUtil.ClearLinePrefixSymbol(arg_869_1.text_)

				local var_872_9 = 18 <= 0 and var_872_5 or var_872_5 * (utf8.len(var_872_7) / 18)

				if (18 <= 0 and var_872_5 or var_872_5 * (utf8.len(var_872_7) / 18)) > 0 and var_872_5 < var_872_9 then
					arg_869_1.talkMaxDuration = var_872_9

					if var_872_9 + var_872_4 > arg_869_1.duration_ then
						arg_869_1.duration_ = var_872_9 + var_872_4
					end
				end

				arg_869_1.text_.text = var_872_7
				arg_869_1.typewritter.percent = 0

				arg_869_1.typewritter:SetDirty()
				arg_869_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb") ~= 0 then
					local var_872_10 = manager.audio:GetVoiceLength("story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb") / 1000

					if var_872_10 + var_872_4 > arg_869_1.duration_ then
						arg_869_1.duration_ = var_872_10 + var_872_4
					end

					if var_872_6.prefab_name ~= "" and arg_869_1.actors_[var_872_6.prefab_name] ~= nil then
						local var_872_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_869_1.actors_[var_872_6.prefab_name].transform, "story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb")

						arg_869_1:RecordAudio("1105006208", var_872_11)
						arg_869_1:RecordAudio("1105006208", var_872_11)
					else
						arg_869_1:AudioAction("play", "voice", "story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb")
					end

					arg_869_1:RecordHistoryTalkVoice("story_v_side_new_1105006", "1105006208", "story_v_side_new_1105006.awb")
				end

				arg_869_1:RecordContent(arg_869_1.text_.text)
			end

			local var_872_12 = math.max(var_872_5, arg_869_1.talkMaxDuration)

			if var_872_4 <= arg_869_1.time_ and arg_869_1.time_ < var_872_4 + var_872_12 then
				arg_869_1.typewritter.percent = (arg_869_1.time_ - var_872_4) / var_872_12

				arg_869_1.typewritter:SetDirty()
			end

			if arg_869_1.time_ >= var_872_4 + var_872_12 and arg_869_1.time_ < var_872_4 + var_872_12 + arg_872_0 then
				arg_869_1.typewritter.percent = 1

				arg_869_1.typewritter:SetDirty()
				arg_869_1:ShowNextGo(true)
			end
		end

		arg_869_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_869_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST16",
		"TextureConfig/Background/ST11",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/R5002",
		"TextureConfig/Background/R5002a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_new_1105006.awb"
	}
}

return {
	Play414211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H07g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07g")
				var_4_0.name = "H07g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H07g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H07g

				arg_1_1.bgs_.H07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H07g" then
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414211001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)

				if (10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play414211002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414211002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414211003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "102201ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["102201ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["102201ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["102201ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["102201ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["102201ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos102201ui_story = var_12_3.localPosition

				arg_9_1:ShowWeapon(arg_9_1.var_["102201ui_story" .. "Animator"].transform, false)
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.08, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["102201ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect102201ui_story == nil then
				arg_9_1.var_.characterEffect102201ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect102201ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect102201ui_story then
				arg_9_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_12_8 = 0
			local var_12_9 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(414211002).content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 22 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_10) / 22)

				if (22 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_10) / 22)) > 0 and var_12_9 < var_12_12 then
					arg_9_1.talkMaxDuration = var_12_12

					if var_12_12 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_13 and arg_9_1.time_ < var_12_8 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
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
	Play414211003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414211003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414211004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos102201ui_story = arg_13_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["102201ui_story"].transform.position).z)
				arg_13_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["102201ui_story"].transform.localEulerAngles = arg_13_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["102201ui_story"].transform.position).z)
				arg_13_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["102201ui_story"].transform.localEulerAngles = arg_13_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["102201ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect102201ui_story == nil then
				arg_13_1.var_.characterEffect102201ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect102201ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_13_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect102201ui_story then
				arg_13_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_13_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_16_3 = "104902ui_story"

			if arg_13_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_16_4 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_13_1.stage_.transform)

				var_16_4.name = var_16_3
				var_16_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_3] = var_16_4

				local var_16_5 = var_16_4:GetComponentInChildren(typeof(CharacterEffect))

				var_16_5.enabled = true

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_4, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_5.transform, false)

				arg_13_1.var_[var_16_3 .. "Animator"] = var_16_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_3 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_3 .. "LipSync"] = var_16_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_7 = arg_13_1.actors_["104902ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos104902ui_story = var_16_7.localPosition
			end

			local var_16_8 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 then
				var_16_7.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_13_1.time_ - 0) / var_16_8)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 then
				var_16_7.localPosition = Vector3.New(0, -1.2, -6)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			local var_16_9 = arg_13_1.actors_["104902ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect104902ui_story == nil then
				arg_13_1.var_.characterEffect104902ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_10 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_10 and not isNil(var_16_9) then
				if arg_13_1.var_.characterEffect104902ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_10 and arg_13_1.time_ < 0 + var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect104902ui_story then
				arg_13_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_1")
			end

			local var_16_12 = 0
			local var_16_13 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(414211003).content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 24 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_14) / 24)

				if (24 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_14) / 24)) > 0 and var_16_13 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_17 and arg_13_1.time_ < var_16_12 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play414211004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414211004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414211005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["104902ui_story"]) and arg_17_1.var_.characterEffect104902ui_story == nil then
				arg_17_1.var_.characterEffect104902ui_story = arg_17_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["104902ui_story"]) then
				if arg_17_1.var_.characterEffect104902ui_story and not isNil(arg_17_1.actors_["104902ui_story"]) then
					arg_17_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_17_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["104902ui_story"]) and arg_17_1.var_.characterEffect104902ui_story then
				arg_17_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_17_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.375

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

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(414211004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 15 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 15)

				if (15 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 15)) > 0 and var_20_2 < var_20_5 then
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
	Play414211005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414211005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414211006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos104902ui_story = arg_21_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["104902ui_story"].transform.position).z)
				arg_21_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["104902ui_story"].transform.localEulerAngles = arg_21_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["104902ui_story"].transform.position).z)
				arg_21_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["104902ui_story"].transform.localEulerAngles = arg_21_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["104902ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect104902ui_story == nil then
				arg_21_1.var_.characterEffect104902ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect104902ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_21_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_2)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect104902ui_story then
				arg_21_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_21_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_24_3 = 0
			local var_24_4 = 0.35

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(414211005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 14 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 14)

				if (14 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 14)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play414211006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414211006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414211007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos102201ui_story = arg_25_1.actors_["102201ui_story"].transform.localPosition

				arg_25_1:ShowWeapon(arg_25_1.var_["102201ui_story" .. "Animator"].transform, false)
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["102201ui_story"].transform.position).z)
				arg_25_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["102201ui_story"].transform.localEulerAngles = arg_25_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_25_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["102201ui_story"].transform.position).z)
				arg_25_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["102201ui_story"].transform.localEulerAngles = arg_25_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["102201ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect102201ui_story == nil then
				arg_25_1.var_.characterEffect102201ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect102201ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect102201ui_story then
				arg_25_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			local var_28_4 = 0
			local var_28_5 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(414211006).content)

				arg_25_1.text_.text = var_28_6

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 17 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_6) / 17)

				if (17 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_6) / 17)) > 0 and var_28_5 < var_28_8 then
					arg_25_1.talkMaxDuration = var_28_8

					if var_28_8 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_6
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_9 and arg_25_1.time_ < var_28_4 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play414211007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 414211007
		arg_29_1.duration_ = 8.9

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play414211008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				local var_32_0 = arg_29_1.bgs_.H07g

				arg_29_1.bgs_.H07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_1 = var_32_0:GetComponent("SpriteRenderer")

				if var_32_1 and var_32_1.sprite then
					local var_32_2 = 2 * (var_32_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_0.transform.localScale = Vector3.New(var_32_2 / var_32_1.sprite.bounds.size.y < var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x and var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x or var_32_2 / var_32_1.sprite.bounds.size.y, var_32_2 / var_32_1.sprite.bounds.size.y < var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x and var_32_2 * manager.ui.mainCameraCom_.aspect / var_32_1.sprite.bounds.size.x or var_32_2 / var_32_1.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "H07g" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_3 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_4 = 2

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_4 then
				local var_32_5 = Color.New(0, 0, 0)

				var_32_5.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_3) / var_32_4)
				arg_29_1.mask_.color = var_32_5
			end

			if arg_29_1.time_ >= var_32_3 + var_32_4 and arg_29_1.time_ < var_32_3 + var_32_4 + arg_32_0 then
				local var_32_6 = Color.New(0, 0, 0)

				var_32_6.a = 1
				arg_29_1.mask_.color = var_32_6
			end

			local var_32_7 = 2

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_8 = 2

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 then
				local var_32_9 = Color.New(0, 0, 0)

				var_32_9.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_7) / var_32_8)
				arg_29_1.mask_.color = var_32_9
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 then
				local var_32_10 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_10.a = 0
				arg_29_1.mask_.color = var_32_10
			end

			local var_32_11 = arg_29_1.actors_["102201ui_story"].transform

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				arg_29_1.var_.moveOldPos102201ui_story = var_32_11.localPosition
			end

			local var_32_12 = 0.001

			if 2 <= arg_29_1.time_ and arg_29_1.time_ < 2 + var_32_12 then
				var_32_11.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 2) / var_32_12)
				var_32_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_11.position).x, (manager.ui.mainCamera.transform.position - var_32_11.position).y, (manager.ui.mainCamera.transform.position - var_32_11.position).z)
				var_32_11.localEulerAngles.z = 0
				var_32_11.localEulerAngles.x = 0
				var_32_11.localEulerAngles = var_32_11.localEulerAngles
			end

			if arg_29_1.time_ >= 2 + var_32_12 and arg_29_1.time_ < 2 + var_32_12 + arg_32_0 then
				var_32_11.localPosition = Vector3.New(0, 100, 0)
				var_32_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_11.position).x, (manager.ui.mainCamera.transform.position - var_32_11.position).y, (manager.ui.mainCamera.transform.position - var_32_11.position).z)
				var_32_11.localEulerAngles.z = 0
				var_32_11.localEulerAngles.x = 0
				var_32_11.localEulerAngles = var_32_11.localEulerAngles
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_13 = 3.9
			local var_32_14 = 1.2

			if 3.9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_15 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_15:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_16 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(414211007).content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_18 = 48 <= 0 and var_32_14 or var_32_14 * (utf8.len(var_32_16) / 48)

				if (48 <= 0 and var_32_14 or var_32_14 * (utf8.len(var_32_16) / 48)) > 0 and var_32_14 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18
					var_32_13 = var_32_13 + 0.3

					if var_32_18 + var_32_13 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_13
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = var_32_13 + 0.3
			local var_32_20 = math.max(var_32_14, arg_29_1.talkMaxDuration)

			if var_32_13 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_19) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_19 + var_32_20 and arg_29_1.time_ < var_32_19 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play414211008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 414211008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play414211009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos104902ui_story = arg_35_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).z)
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles = arg_35_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_35_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).z)
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles = arg_35_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["104902ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect104902ui_story == nil then
				arg_35_1.var_.characterEffect104902ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect104902ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect104902ui_story then
				arg_35_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_2")
			end

			local var_38_4 = 0
			local var_38_5 = 0.2

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(414211008).content)

				arg_35_1.text_.text = var_38_6

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_8 = 8 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 8)

				if (8 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 8)) > 0 and var_38_5 < var_38_8 then
					arg_35_1.talkMaxDuration = var_38_8

					if var_38_8 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_6
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_9 and arg_35_1.time_ < var_38_4 + var_38_9 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play414211009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414211009
		arg_39_1.duration_ = 7.2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414211010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.bgs_.H09f == nil then
				local var_42_0 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H09f")
				var_42_0.name = "H09f"
				var_42_0.transform.parent = arg_39_1.stage_.transform
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_.H09f = var_42_0
			end

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				local var_42_1 = arg_39_1.bgs_.H09f

				arg_39_1.bgs_.H09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_2 = var_42_1:GetComponent("SpriteRenderer")

				if var_42_2 and var_42_2.sprite then
					local var_42_3 = 2 * (var_42_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_1.transform.localScale = Vector3.New(var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "H09f" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_4 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= var_42_4 + 0.3 and arg_39_1.time_ < var_42_4 + 0.3 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_5 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_6 = 2

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 then
				local var_42_7 = Color.New(0, 0, 0)

				var_42_7.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_5) / var_42_6)
				arg_39_1.mask_.color = var_42_7
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 then
				local var_42_8 = Color.New(0, 0, 0)

				var_42_8.a = 1
				arg_39_1.mask_.color = var_42_8
			end

			local var_42_9 = 2

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_10 = 2

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 then
				local var_42_11 = Color.New(0, 0, 0)

				var_42_11.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_9) / var_42_10)
				arg_39_1.mask_.color = var_42_11
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 then
				local var_42_12 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_12.a = 0
				arg_39_1.mask_.color = var_42_12
			end

			local var_42_13 = arg_39_1.actors_["104902ui_story"].transform

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				arg_39_1.var_.moveOldPos104902ui_story = var_42_13.localPosition
			end

			local var_42_14 = 0.001

			if 2 <= arg_39_1.time_ and arg_39_1.time_ < 2 + var_42_14 then
				var_42_13.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 2) / var_42_14)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			if arg_39_1.time_ >= 2 + var_42_14 and arg_39_1.time_ < 2 + var_42_14 + arg_42_0 then
				var_42_13.localPosition = Vector3.New(0, 100, 0)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			local var_42_15 = arg_39_1.actors_["104902ui_story"]

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 and not isNil(var_42_15) and arg_39_1.var_.characterEffect104902ui_story == nil then
				arg_39_1.var_.characterEffect104902ui_story = var_42_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_16 = 0.200000002980232

			if 2 <= arg_39_1.time_ and arg_39_1.time_ < 2 + var_42_16 and not isNil(var_42_15) then
				if arg_39_1.var_.characterEffect104902ui_story and not isNil(var_42_15) then
					arg_39_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_39_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 2) / var_42_16)
				end
			end

			if arg_39_1.time_ >= 2 + var_42_16 and arg_39_1.time_ < 2 + var_42_16 + arg_42_0 and not isNil(var_42_15) and arg_39_1.var_.characterEffect104902ui_story then
				arg_39_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_39_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				arg_39_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_battle_beach", "bgm_activity_1_2_summer1_battle_beach", "bgm_activity_1_2_summer1_battle_beach.awb")

				local var_42_19 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_battle_beach", "bgm_activity_1_2_summer1_battle_beach")

				if "" ~= "" then
					if arg_39_1.bgmTxt_.text ~= var_42_19 and arg_39_1.bgmTxt_.text ~= "" then
						if arg_39_1.bgmTxt2_.text ~= "" then
							arg_39_1.bgmTxt_.text = arg_39_1.bgmTxt2_.text
						end

						arg_39_1.bgmTxt2_.text = var_42_19

						arg_39_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_39_1.bgmTxt_.text = var_42_19
						arg_39_1.bgmTxt2_.text = var_42_19
					end

					if arg_39_1.bgmTimer then
						arg_39_1.bgmTimer:Stop()

						arg_39_1.bgmTimer = nil
					end

					if arg_39_1.settingData.show_music_name == 1 then
						arg_39_1.musicController:SetSelectedState("show")
						arg_39_1.musicAnimator_:Play("open", 0, 0)

						if arg_39_1.settingData.music_time ~= 0 then
							arg_39_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_39_1.settingData.music_time), function()
								if arg_39_1 == nil or isNil(arg_39_1.bgmTxt_) then
									return
								end

								arg_39_1.musicController:SetSelectedState("hide")
								arg_39_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_20 = 2.20000000298023
			local var_42_21 = 0.55

			if 2.20000000298023 < arg_39_1.time_ and arg_39_1.time_ <= var_42_20 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_22 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_22:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_39_1.dialogCg_.alpha = arg_44_0
				end))
				var_42_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_23 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(414211009).content)

				arg_39_1.text_.text = var_42_23

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_25 = 22 <= 0 and var_42_21 or var_42_21 * (utf8.len(var_42_23) / 22)

				if (22 <= 0 and var_42_21 or var_42_21 * (utf8.len(var_42_23) / 22)) > 0 and var_42_21 < var_42_25 then
					arg_39_1.talkMaxDuration = var_42_25
					var_42_20 = var_42_20 + 0.3

					if var_42_25 + var_42_20 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_25 + var_42_20
					end
				end

				arg_39_1.text_.text = var_42_23
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_26 = var_42_20 + 0.3
			local var_42_27 = math.max(var_42_21, arg_39_1.talkMaxDuration)

			if var_42_20 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_26 + var_42_27 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_26) / var_42_27

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_26 + var_42_27 and arg_39_1.time_ < var_42_26 + var_42_27 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play414211010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 414211010
		arg_46_1.duration_ = 1

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"

			SetActive(arg_46_1.choicesGo_, true)

			for iter_47_0, iter_47_1 in ipairs(arg_46_1.choices_) do
				SetActive(iter_47_1.go, iter_47_0 <= 2)
			end

			arg_46_1.choices_[1].txt.text = arg_46_1:FormatText(StoryChoiceCfg[859].name)
			arg_46_1.choices_[2].txt.text = arg_46_1:FormatText(StoryChoiceCfg[860].name)
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play414211011(arg_46_1)
			end

			if arg_48_0 == 2 then
				arg_46_0:Play414211012(arg_46_1)
			end

			arg_46_1:RecordChoiceLog(414211010, 859, 860)
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			return
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play414211011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 414211011
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play414211013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["104902ui_story"]) and arg_50_1.var_.characterEffect104902ui_story == nil then
				arg_50_1.var_.characterEffect104902ui_story = arg_50_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["104902ui_story"]) then
				if arg_50_1.var_.characterEffect104902ui_story and not isNil(arg_50_1.actors_["104902ui_story"]) then
					arg_50_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_50_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["104902ui_story"]) and arg_50_1.var_.characterEffect104902ui_story then
				arg_50_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_50_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_53_1 = 0
			local var_53_2 = 0.425

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_3 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(414211011).content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 16 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 16)

				if (16 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 16)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_1
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_6 = math.max(var_53_2, arg_50_1.talkMaxDuration)

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_6 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_1) / var_53_6

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_1 + var_53_6 and arg_50_1.time_ < var_53_1 + var_53_6 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play414211013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 414211013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play414211014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.bgs_.H07f == nil then
				local var_57_0 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07f")
				var_57_0.name = "H07f"
				var_57_0.transform.parent = arg_54_1.stage_.transform
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_.H07f = var_57_0
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				local var_57_1 = arg_54_1.bgs_.H07f

				arg_54_1.bgs_.H07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_57_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_2 = var_57_1:GetComponent("SpriteRenderer")

				if var_57_2 and var_57_2.sprite then
					local var_57_3 = 2 * (var_57_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_57_1.transform.localScale = Vector3.New(var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "H07f" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_4 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.allBtn_.enabled = false
			end

			if arg_54_1.time_ >= var_57_4 + 0.3 and arg_54_1.time_ < var_57_4 + 0.3 + arg_57_0 then
				arg_54_1.allBtn_.enabled = true
			end

			local var_57_5 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_6 = 2

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 then
				local var_57_7 = Color.New(0, 0, 0)

				var_57_7.a = Mathf.Lerp(1, 0, (arg_54_1.time_ - var_57_5) / var_57_6)
				arg_54_1.mask_.color = var_57_7
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 then
				local var_57_8 = Color.New(0, 0, 0)

				arg_54_1.mask_.enabled = false
				var_57_8.a = 0
				arg_54_1.mask_.color = var_57_8
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_57_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_54_1.bgmTxt_.text ~= var_57_11 and arg_54_1.bgmTxt_.text ~= "" then
						if arg_54_1.bgmTxt2_.text ~= "" then
							arg_54_1.bgmTxt_.text = arg_54_1.bgmTxt2_.text
						end

						arg_54_1.bgmTxt2_.text = var_57_11

						arg_54_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_54_1.bgmTxt_.text = var_57_11
						arg_54_1.bgmTxt2_.text = var_57_11
					end

					if arg_54_1.bgmTimer then
						arg_54_1.bgmTimer:Stop()

						arg_54_1.bgmTimer = nil
					end

					if arg_54_1.settingData.show_music_name == 1 then
						arg_54_1.musicController:SetSelectedState("show")
						arg_54_1.musicAnimator_:Play("open", 0, 0)

						if arg_54_1.settingData.music_time ~= 0 then
							arg_54_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_54_1.settingData.music_time), function()
								if arg_54_1 == nil or isNil(arg_54_1.bgmTxt_) then
									return
								end

								arg_54_1.musicController:SetSelectedState("hide")
								arg_54_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_54_1.time_ and arg_54_1.time_ <= 0.366666666666667 + arg_57_0 then
				arg_54_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_battle_jungle", "bgm_activity_1_2_summer1_battle_jungle", "bgm_activity_1_2_summer1_battle_jungle.awb")

				local var_57_14 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_battle_jungle", "bgm_activity_1_2_summer1_battle_jungle")

				if "" ~= "" then
					if arg_54_1.bgmTxt_.text ~= var_57_14 and arg_54_1.bgmTxt_.text ~= "" then
						if arg_54_1.bgmTxt2_.text ~= "" then
							arg_54_1.bgmTxt_.text = arg_54_1.bgmTxt2_.text
						end

						arg_54_1.bgmTxt2_.text = var_57_14

						arg_54_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_54_1.bgmTxt_.text = var_57_14
						arg_54_1.bgmTxt2_.text = var_57_14
					end

					if arg_54_1.bgmTimer then
						arg_54_1.bgmTimer:Stop()

						arg_54_1.bgmTimer = nil
					end

					if arg_54_1.settingData.show_music_name == 1 then
						arg_54_1.musicController:SetSelectedState("show")
						arg_54_1.musicAnimator_:Play("open", 0, 0)

						if arg_54_1.settingData.music_time ~= 0 then
							arg_54_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_54_1.settingData.music_time), function()
								if arg_54_1 == nil or isNil(arg_54_1.bgmTxt_) then
									return
								end

								arg_54_1.musicController:SetSelectedState("hide")
								arg_54_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_57_15 = 0
			local var_57_16 = 0.325

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_17 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_17:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_54_1.dialogCg_.alpha = arg_60_0
				end))
				var_57_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(414211013).content)

				arg_54_1.text_.text = var_57_18

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 13 <= 0 and var_57_16 or var_57_16 * (utf8.len(var_57_18) / 13)

				if (13 <= 0 and var_57_16 or var_57_16 * (utf8.len(var_57_18) / 13)) > 0 and var_57_16 < var_57_20 then
					arg_54_1.talkMaxDuration = var_57_20
					var_57_15 = var_57_15 + 0.3

					if var_57_20 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_20 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_18
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_21 = var_57_15 + 0.3
			local var_57_22 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 + 0.3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_22 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_21) / var_57_22

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_21 + var_57_22 and arg_54_1.time_ < var_57_21 + var_57_22 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play414211014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 414211014
		arg_62_1.duration_ = 1

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"

			SetActive(arg_62_1.choicesGo_, true)

			for iter_63_0, iter_63_1 in ipairs(arg_62_1.choices_) do
				SetActive(iter_63_1.go, iter_63_0 <= 2)
			end

			arg_62_1.choices_[1].txt.text = arg_62_1:FormatText(StoryChoiceCfg[861].name)
			arg_62_1.choices_[2].txt.text = arg_62_1:FormatText(StoryChoiceCfg[862].name)
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play414211016(arg_62_1)
			end

			if arg_64_0 == 2 then
				arg_62_0:Play414211015(arg_62_1)
			end

			arg_62_1:RecordChoiceLog(414211014, 861, 862)
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			return
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play414211016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 414211016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play414211017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.075

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(414211011).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 16 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 16)

				if (16 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 16)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play414211017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 414211017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play414211018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.bgs_.H07h == nil then
				local var_73_0 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07h")
				var_73_0.name = "H07h"
				var_73_0.transform.parent = arg_70_1.stage_.transform
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_.H07h = var_73_0
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				local var_73_1 = arg_70_1.bgs_.H07h

				arg_70_1.bgs_.H07h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_2 = var_73_1:GetComponent("SpriteRenderer")

				if var_73_2 and var_73_2.sprite then
					local var_73_3 = 2 * (var_73_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_1.transform.localScale = Vector3.New(var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "H07h" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_4 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_5 = 2

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_5 then
				local var_73_6 = Color.New(0, 0, 0)

				var_73_6.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_4) / var_73_5)
				arg_70_1.mask_.color = var_73_6
			end

			if arg_70_1.time_ >= var_73_4 + var_73_5 and arg_70_1.time_ < var_73_4 + var_73_5 + arg_73_0 then
				local var_73_7 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_7.a = 0
				arg_70_1.mask_.color = var_73_7
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_73_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_70_1.bgmTxt_.text ~= var_73_10 and arg_70_1.bgmTxt_.text ~= "" then
						if arg_70_1.bgmTxt2_.text ~= "" then
							arg_70_1.bgmTxt_.text = arg_70_1.bgmTxt2_.text
						end

						arg_70_1.bgmTxt2_.text = var_73_10

						arg_70_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_70_1.bgmTxt_.text = var_73_10
						arg_70_1.bgmTxt2_.text = var_73_10
					end

					if arg_70_1.bgmTimer then
						arg_70_1.bgmTimer:Stop()

						arg_70_1.bgmTimer = nil
					end

					if arg_70_1.settingData.show_music_name == 1 then
						arg_70_1.musicController:SetSelectedState("show")
						arg_70_1.musicAnimator_:Play("open", 0, 0)

						if arg_70_1.settingData.music_time ~= 0 then
							arg_70_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_70_1.settingData.music_time), function()
								if arg_70_1 == nil or isNil(arg_70_1.bgmTxt_) then
									return
								end

								arg_70_1.musicController:SetSelectedState("hide")
								arg_70_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 0.366666666666667 + arg_73_0 then
				arg_70_1:AudioAction("play", "music", "bgm_activity_1_6_battle_park_plaza", "bgm_activity_1_6_battle_park_plaza", "bgm_activity_1_6_battle_park_plaza.awb")

				local var_73_13 = manager.audio:GetAudioName("bgm_activity_1_6_battle_park_plaza", "bgm_activity_1_6_battle_park_plaza")

				if "" ~= "" then
					if arg_70_1.bgmTxt_.text ~= var_73_13 and arg_70_1.bgmTxt_.text ~= "" then
						if arg_70_1.bgmTxt2_.text ~= "" then
							arg_70_1.bgmTxt_.text = arg_70_1.bgmTxt2_.text
						end

						arg_70_1.bgmTxt2_.text = var_73_13

						arg_70_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_70_1.bgmTxt_.text = var_73_13
						arg_70_1.bgmTxt2_.text = var_73_13
					end

					if arg_70_1.bgmTimer then
						arg_70_1.bgmTimer:Stop()

						arg_70_1.bgmTimer = nil
					end

					if arg_70_1.settingData.show_music_name == 1 then
						arg_70_1.musicController:SetSelectedState("show")
						arg_70_1.musicAnimator_:Play("open", 0, 0)

						if arg_70_1.settingData.music_time ~= 0 then
							arg_70_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_70_1.settingData.music_time), function()
								if arg_70_1 == nil or isNil(arg_70_1.bgmTxt_) then
									return
								end

								arg_70_1.musicController:SetSelectedState("hide")
								arg_70_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_73_14 = 0
			local var_73_15 = 0.2

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_16 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_16:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_70_1.dialogCg_.alpha = arg_76_0
				end))
				var_73_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_17 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(414211015).content)

				arg_70_1.text_.text = var_73_17

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_19 = 13 <= 0 and var_73_15 or var_73_15 * (utf8.len(var_73_17) / 13)

				if (13 <= 0 and var_73_15 or var_73_15 * (utf8.len(var_73_17) / 13)) > 0 and var_73_15 < var_73_19 then
					arg_70_1.talkMaxDuration = var_73_19
					var_73_14 = var_73_14 + 0.3

					if var_73_19 + var_73_14 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_14
					end
				end

				arg_70_1.text_.text = var_73_17
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_20 = var_73_14 + 0.3
			local var_73_21 = math.max(var_73_15, arg_70_1.talkMaxDuration)

			if var_73_14 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_20 + var_73_21 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_20) / var_73_21

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_20 + var_73_21 and arg_70_1.time_ < var_73_20 + var_73_21 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play414211018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 414211018
		arg_78_1.duration_ = 1

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"

			SetActive(arg_78_1.choicesGo_, true)

			for iter_79_0, iter_79_1 in ipairs(arg_78_1.choices_) do
				SetActive(iter_79_1.go, iter_79_0 <= 2)
			end

			arg_78_1.choices_[1].txt.text = arg_78_1:FormatText(StoryChoiceCfg[863].name)
			arg_78_1.choices_[2].txt.text = arg_78_1:FormatText(StoryChoiceCfg[864].name)
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play414211019(arg_78_1)
			end

			if arg_80_0 == 2 then
				arg_78_0:Play414211020(arg_78_1)
			end

			arg_78_1:RecordChoiceLog(414211018, 863, 864)
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			return
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play414211019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 414211019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play414211021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= 0 + 0.3 and arg_82_1.time_ < 0 + 0.3 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_0 = 0
			local var_85_1 = 0.2

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_2 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_2:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(414211017).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 8 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 8)

				if (8 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 8)) > 0 and var_85_1 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5
					var_85_0 = var_85_0 + 0.3

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = var_85_0 + 0.3
			local var_85_7 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play414211021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 414211021
		arg_88_1.duration_ = 7

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play414211022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				local var_91_0 = arg_88_1.bgs_.H07f

				arg_88_1.bgs_.H07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_1 = var_91_0:GetComponent("SpriteRenderer")

				if var_91_1 and var_91_1.sprite then
					local var_91_2 = 2 * (var_91_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_0.transform.localScale = Vector3.New(var_91_2 / var_91_1.sprite.bounds.size.y < var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x and var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x or var_91_2 / var_91_1.sprite.bounds.size.y, var_91_2 / var_91_1.sprite.bounds.size.y < var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x and var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x or var_91_2 / var_91_1.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "H07f" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_3 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			if arg_88_1.time_ >= var_91_3 + 0.3 and arg_88_1.time_ < var_91_3 + 0.3 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_4 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_5 = 2

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_5 then
				local var_91_6 = Color.New(0, 0, 0)

				var_91_6.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_4) / var_91_5)
				arg_88_1.mask_.color = var_91_6
			end

			if arg_88_1.time_ >= var_91_4 + var_91_5 and arg_88_1.time_ < var_91_4 + var_91_5 + arg_91_0 then
				local var_91_7 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_7.a = 0
				arg_88_1.mask_.color = var_91_7
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_91_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_10 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_10

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_10
						arg_88_1.bgmTxt2_.text = var_91_10
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_88_1.time_ and arg_88_1.time_ <= 0.366666666666667 + arg_91_0 then
				arg_88_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_91_13 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_13 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_13

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_13
						arg_88_1.bgmTxt2_.text = var_91_13
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_14 = 2
			local var_91_15 = 1.225

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_16 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_16:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_88_1.dialogCg_.alpha = arg_94_0
				end))
				var_91_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_17 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(414211019).content)

				arg_88_1.text_.text = var_91_17

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_19 = 49 <= 0 and var_91_15 or var_91_15 * (utf8.len(var_91_17) / 49)

				if (49 <= 0 and var_91_15 or var_91_15 * (utf8.len(var_91_17) / 49)) > 0 and var_91_15 < var_91_19 then
					arg_88_1.talkMaxDuration = var_91_19
					var_91_14 = var_91_14 + 0.3

					if var_91_19 + var_91_14 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_14
					end
				end

				arg_88_1.text_.text = var_91_17
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_20 = var_91_14 + 0.3
			local var_91_21 = math.max(var_91_15, arg_88_1.talkMaxDuration)

			if var_91_14 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_21 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_20) / var_91_21

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_20 + var_91_21 and arg_88_1.time_ < var_91_20 + var_91_21 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play414211022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 414211022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play414211023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["104902ui_story"]) and arg_96_1.var_.characterEffect104902ui_story == nil then
				arg_96_1.var_.characterEffect104902ui_story = arg_96_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["104902ui_story"]) then
				if arg_96_1.var_.characterEffect104902ui_story and not isNil(arg_96_1.actors_["104902ui_story"]) then
					arg_96_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_96_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["104902ui_story"]) and arg_96_1.var_.characterEffect104902ui_story then
				arg_96_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_96_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.375

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(414211020).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 9)

				if (9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 9)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play414211023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 414211023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play414211024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos104902ui_story = arg_100_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["104902ui_story"].transform.position).z)
				arg_100_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["104902ui_story"].transform.localEulerAngles = arg_100_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_100_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["104902ui_story"].transform.position).z)
				arg_100_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["104902ui_story"].transform.localEulerAngles = arg_100_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["104902ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect104902ui_story == nil then
				arg_100_1.var_.characterEffect104902ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect104902ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect104902ui_story then
				arg_100_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_103_4 = 0
			local var_103_5 = 0.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(414211021).content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_8 = 10 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_6) / 10)

				if (10 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_6) / 10)) > 0 and var_103_5 < var_103_8 then
					arg_100_1.talkMaxDuration = var_103_8

					if var_103_8 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_9 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_9 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_9

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_9 and arg_100_1.time_ < var_103_4 + var_103_9 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play414211024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 414211024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play414211025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["104902ui_story"]) and arg_104_1.var_.characterEffect104902ui_story == nil then
				arg_104_1.var_.characterEffect104902ui_story = arg_104_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["104902ui_story"]) then
				if arg_104_1.var_.characterEffect104902ui_story and not isNil(arg_104_1.actors_["104902ui_story"]) then
					arg_104_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_104_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["104902ui_story"]) and arg_104_1.var_.characterEffect104902ui_story then
				arg_104_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_104_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0
			local var_107_2 = 0.375

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(414211022).content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 15 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 15)

				if (15 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 15)) > 0 and var_107_2 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_6 = math.max(var_107_2, arg_104_1.talkMaxDuration)

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_6 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_1) / var_107_6

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_1 + var_107_6 and arg_104_1.time_ < var_107_1 + var_107_6 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play414211025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 414211025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play414211026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.125

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(414211023).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 17 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 17)

				if (17 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 17)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play414211026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 414211026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play414211027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos104902ui_story = arg_112_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104902ui_story"].transform.position).z)
				arg_112_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["104902ui_story"].transform.localEulerAngles = arg_112_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_112_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104902ui_story"].transform.position).z)
				arg_112_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["104902ui_story"].transform.localEulerAngles = arg_112_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["104902ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect104902ui_story == nil then
				arg_112_1.var_.characterEffect104902ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect104902ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect104902ui_story then
				arg_112_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action2_1")
			end

			local var_115_4 = 0
			local var_115_5 = 0.625

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(414211024).content)

				arg_112_1.text_.text = var_115_6

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_8 = 25 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_6) / 25)

				if (25 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_6) / 25)) > 0 and var_115_5 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8

					if var_115_8 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_6
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_9 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_9 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_9

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_9 and arg_112_1.time_ < var_115_4 + var_115_9 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play414211027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 414211027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play414211028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["104902ui_story"]) and arg_116_1.var_.characterEffect104902ui_story == nil then
				arg_116_1.var_.characterEffect104902ui_story = arg_116_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["104902ui_story"]) then
				if arg_116_1.var_.characterEffect104902ui_story and not isNil(arg_116_1.actors_["104902ui_story"]) then
					arg_116_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_116_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["104902ui_story"]) and arg_116_1.var_.characterEffect104902ui_story then
				arg_116_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_116_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.125

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(414211025).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 5 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 5)

				if (5 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 5)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play414211028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 414211028
		arg_120_1.duration_ = 8.83

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play414211029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if arg_120_1.bgs_.H07j == nil then
				local var_123_0 = Object.Instantiate(arg_120_1.paintGo_)

				var_123_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07j")
				var_123_0.name = "H07j"
				var_123_0.transform.parent = arg_120_1.stage_.transform
				var_123_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.bgs_.H07j = var_123_0
			end

			if 1.975 < arg_120_1.time_ and arg_120_1.time_ <= 1.975 + arg_123_0 then
				local var_123_1 = arg_120_1.bgs_.H07j

				arg_120_1.bgs_.H07j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_123_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_2 = var_123_1:GetComponent("SpriteRenderer")

				if var_123_2 and var_123_2.sprite then
					local var_123_3 = 2 * (var_123_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_123_1.transform.localScale = Vector3.New(var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "H07j" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_4 = arg_120_1.actors_["104902ui_story"].transform

			if 2 < arg_120_1.time_ and arg_120_1.time_ <= 2 + arg_123_0 then
				arg_120_1.var_.moveOldPos104902ui_story = var_123_4.localPosition
			end

			local var_123_5 = 0.001

			if 2 <= arg_120_1.time_ and arg_120_1.time_ < 2 + var_123_5 then
				var_123_4.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 2) / var_123_5)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles
			end

			if arg_120_1.time_ >= 2 + var_123_5 and arg_120_1.time_ < 2 + var_123_5 + arg_123_0 then
				var_123_4.localPosition = Vector3.New(0, 100, 0)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles
			end

			local var_123_6 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_7 = 2

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_7 then
				local var_123_8 = Color.New(0, 0, 0)

				var_123_8.a = Mathf.Lerp(0, 1, (arg_120_1.time_ - var_123_6) / var_123_7)
				arg_120_1.mask_.color = var_123_8
			end

			if arg_120_1.time_ >= var_123_6 + var_123_7 and arg_120_1.time_ < var_123_6 + var_123_7 + arg_123_0 then
				local var_123_9 = Color.New(0, 0, 0)

				var_123_9.a = 1
				arg_120_1.mask_.color = var_123_9
			end

			local var_123_10 = 2

			if 2 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_11 = 2

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 then
				local var_123_12 = Color.New(0, 0, 0)

				var_123_12.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_10) / var_123_11)
				arg_120_1.mask_.color = var_123_12
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 then
				local var_123_13 = Color.New(0, 0, 0)

				arg_120_1.mask_.enabled = false
				var_123_13.a = 0
				arg_120_1.mask_.color = var_123_13
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_14 = 3.83333333333333
			local var_123_15 = 1.025

			if 3.83333333333333 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_16 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_16:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_17 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(414211026).content)

				arg_120_1.text_.text = var_123_17

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_19 = 41 <= 0 and var_123_15 or var_123_15 * (utf8.len(var_123_17) / 41)

				if (41 <= 0 and var_123_15 or var_123_15 * (utf8.len(var_123_17) / 41)) > 0 and var_123_15 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19
					var_123_14 = var_123_14 + 0.3

					if var_123_19 + var_123_14 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_14
					end
				end

				arg_120_1.text_.text = var_123_17
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_20 = var_123_14 + 0.3
			local var_123_21 = math.max(var_123_15, arg_120_1.talkMaxDuration)

			if var_123_14 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_20 + var_123_21 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_20) / var_123_21

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_20 + var_123_21 and arg_120_1.time_ < var_123_20 + var_123_21 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play414211029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 414211029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play414211030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.7

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(414211027).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 28 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 28)

				if (28 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 28)) > 0 and var_129_0 < var_129_3 then
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
	Play414211030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 414211030
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play414211031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.6

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(414211028).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 24 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 24)

				if (24 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 24)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play414211031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 414211031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play414211032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos102201ui_story = arg_134_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102201ui_story"].transform.position).z)
				arg_134_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["102201ui_story"].transform.localEulerAngles = arg_134_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_134_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102201ui_story"].transform.position).z)
				arg_134_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["102201ui_story"].transform.localEulerAngles = arg_134_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["102201ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect102201ui_story == nil then
				arg_134_1.var_.characterEffect102201ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect102201ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect102201ui_story then
				arg_134_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			local var_137_4 = 0
			local var_137_5 = 0.225

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(414211029).content)

				arg_134_1.text_.text = var_137_6

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_8 = 5 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_6) / 5)

				if (5 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_6) / 5)) > 0 and var_137_5 < var_137_8 then
					arg_134_1.talkMaxDuration = var_137_8

					if var_137_8 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_6
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_9 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_9 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_9

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_9 and arg_134_1.time_ < var_137_4 + var_137_9 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play414211032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 414211032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play414211033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.45

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(414211030).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 12 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 12)

				if (12 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 12)) > 0 and var_141_0 < var_141_3 then
					arg_138_1.talkMaxDuration = var_141_3

					if var_141_3 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_3 + 0
					end
				end

				arg_138_1.text_.text = var_141_1
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_4 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_4

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play414211033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 414211033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play414211034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["102201ui_story"]) and arg_142_1.var_.characterEffect102201ui_story == nil then
				arg_142_1.var_.characterEffect102201ui_story = arg_142_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["102201ui_story"]) then
				if arg_142_1.var_.characterEffect102201ui_story and not isNil(arg_142_1.actors_["102201ui_story"]) then
					arg_142_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_142_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["102201ui_story"]) and arg_142_1.var_.characterEffect102201ui_story then
				arg_142_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_142_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 0.225

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

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(414211031).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 9 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 9)

				if (9 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 9)) > 0 and var_145_2 < var_145_5 then
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
	Play414211034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 414211034
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play414211035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos104902ui_story = arg_146_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["104902ui_story"].transform.position).z)
				arg_146_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["104902ui_story"].transform.localEulerAngles = arg_146_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_146_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["104902ui_story"].transform.position).z)
				arg_146_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["104902ui_story"].transform.localEulerAngles = arg_146_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["104902ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect104902ui_story == nil then
				arg_146_1.var_.characterEffect104902ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect104902ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect104902ui_story then
				arg_146_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_149_4 = arg_146_1.actors_["102201ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos102201ui_story = var_149_4.localPosition
			end

			local var_149_5 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_5 then
				var_149_4.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_5)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_5 and arg_146_1.time_ < 0 + var_149_5 + arg_149_0 then
				var_149_4.localPosition = Vector3.New(0, 100, 0)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			local var_149_6 = arg_146_1.actors_["102201ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect102201ui_story == nil then
				arg_146_1.var_.characterEffect102201ui_story = var_149_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_7 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 and not isNil(var_149_6) then
				if arg_146_1.var_.characterEffect102201ui_story and not isNil(var_149_6) then
					arg_146_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_146_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_7)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect102201ui_story then
				arg_146_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_146_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action2_2")
			end

			local var_149_8 = 0
			local var_149_9 = 0.425

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_10 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(414211032).content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_12 = 18 <= 0 and var_149_9 or var_149_9 * (utf8.len(var_149_10) / 18)

				if (18 <= 0 and var_149_9 or var_149_9 * (utf8.len(var_149_10) / 18)) > 0 and var_149_9 < var_149_12 then
					arg_146_1.talkMaxDuration = var_149_12

					if var_149_12 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_12 + var_149_8
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_13 = math.max(var_149_9, arg_146_1.talkMaxDuration)

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_13 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_8) / var_149_13

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_8 + var_149_13 and arg_146_1.time_ < var_149_8 + var_149_13 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play414211035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 414211035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play414211036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["104902ui_story"]) and arg_150_1.var_.characterEffect104902ui_story == nil then
				arg_150_1.var_.characterEffect104902ui_story = arg_150_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["104902ui_story"]) then
				if arg_150_1.var_.characterEffect104902ui_story and not isNil(arg_150_1.actors_["104902ui_story"]) then
					arg_150_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_150_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_0)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["104902ui_story"]) and arg_150_1.var_.characterEffect104902ui_story then
				arg_150_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_150_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_153_1 = 0
			local var_153_2 = 0.425

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

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(414211033).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 41 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 41)

				if (41 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 41)) > 0 and var_153_2 < var_153_5 then
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

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play414211036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 414211036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
			arg_154_1.auto_ = false
		end

		function arg_154_1.playNext_(arg_156_0)
			arg_154_1.onStoryFinished_()
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.425

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(414211034).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 17 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 17)

				if (17 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 17)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play414211020 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 414211020
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play414211021(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.225

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(414211012).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 18 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 18)

				if (18 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 18)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play414211015 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 414211015
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play414211017(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.allBtn_.enabled = false
			end

			if arg_162_1.time_ >= 0 + 0.3 and arg_162_1.time_ < 0 + 0.3 + arg_165_0 then
				arg_162_1.allBtn_.enabled = true
			end

			local var_165_0 = 0
			local var_165_1 = 0.325

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_2 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_2:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_162_1.dialogCg_.alpha = arg_166_0
				end))
				var_165_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(414211012).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 18 <= 0 and var_165_1 or var_165_1 * (utf8.len(var_165_3) / 18)

				if (18 <= 0 and var_165_1 or var_165_1 * (utf8.len(var_165_3) / 18)) > 0 and var_165_1 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5
					var_165_0 = var_165_0 + 0.3

					if var_165_5 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = var_165_0 + 0.3
			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 + 0.3 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_7 and arg_162_1.time_ < var_165_6 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play414211012 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 414211012
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play414211013(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.45

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(414211012).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 18 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 18)

				if (18 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 18)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H07g",
		"TextureConfig/Background/H09f",
		"TextureConfig/Background/H07f",
		"TextureConfig/Background/H07h",
		"TextureConfig/Background/H07j"
	},
	voices = {}
}
